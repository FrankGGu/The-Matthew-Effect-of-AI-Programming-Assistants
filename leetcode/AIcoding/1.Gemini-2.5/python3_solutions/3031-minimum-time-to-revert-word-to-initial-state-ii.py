class Solution:
    def minimumTimeToRevertWord(self, word: str, k: int) -> int:
        n = len(word)

        # Z-algorithm implementation
        # Z[i] is the length of the longest common prefix between word and word[i:]
        z = [0] * n
        l, r = 0, 0
        for i in range(1, n):
            if i <= r:
                z[i] = min(r - i + 1, z[i - l])
            while i + z[i] < n and word[z[i]] == word[i + z[i]]:
                z[i] += 1
            if i + z[i] - 1 > r:
                l = i
                r = i + z[i] - 1

        # We need to find the minimum t such that after t operations,
        # the prefix of the current word of length (n - t*k) matches
        # the prefix of the original word of length (n - t*k).
        #
        # After t operations, the string becomes `word[t*k:] + word[:t*k]`.
        # The prefix of this new string of length (n - t*k) is `word[t*k : n]`.
        # We need to check if `word[t*k : n]` == `word[0 : n - t*k]`.
        # This is equivalent to checking if Z[t*k] >= (n - t*k).

        for t in range(1, n + 1):
            current_shift = t * k

            # If current_shift >= n, it means the entire string has been shifted out.
            # The length of the prefix to match, (n - current_shift), is 0 or negative.
            # An empty prefix always matches an empty prefix. So this t is a valid answer.
            if current_shift >= n:
                return t

            # Check if the suffix of `word` starting at `current_shift`
            # matches the prefix of `word` of length `n - current_shift`.
            # This is true if `Z[current_shift]` is at least `n - current_shift`.
            if z[current_shift] >= (n - current_shift):
                return t

        # This line should theoretically not be reached because `t*k >= n` will always
        # eventually be true, returning `t`. For example, if k=1, t=n will result in
        # current_shift = n, triggering the first `if` condition.
        return n