import collections

class Solution:
    def longestSubsequenceRepeatedK(self, s: str, k: int) -> str:
        n = len(s)

        # Precompute next_char table
        # next_char[i][char_code] stores the index of the first occurrence of `char` in `s`
        # at or after index `i`.
        # If no such character exists, it's -1.
        next_char = [[-1] * 26 for _ in range(n + 1)]
        for i in range(n - 1, -1, -1):
            for j in range(26):
                next_char[i][j] = next_char[i+1][j]
            next_char[i][ord(s[i]) - ord('a')] = i

        # Helper function to check if `pattern` repeated `k` times is a subsequence of `s`
        def check_subsequence(pattern: str) -> bool:
            if not pattern:
                return True

            curr_s_idx = 0
            for _ in range(k):
                for char_p in pattern:
                    char_code = ord(char_p) - ord('a')

                    # If curr_s_idx is out of bounds, it means we've exhausted `s`
                    # and cannot find the current character.
                    # next_char[n] contains all -1s, so this check is implicitly handled
                    # by next_char lookup if curr_s_idx becomes n.
                    if curr_s_idx >= n: 
                        return False

                    next_idx = next_char[curr_s_idx][char_code]

                    if next_idx == -1:
                        return False

                    curr_s_idx = next_idx + 1
            return True

        # BFS to find the longest and lexicographically largest `sub`
        q = collections.deque([""])
        ans = ""

        while q:
            curr_sub = q.popleft()

            # Iterate characters from 'z' down to 'a' to ensure lexicographically largest
            for char_code in range(ord('z'), ord('a') - 1, -1):
                char = chr(char_code)
                next_sub = curr_sub + char

                if check_subsequence(next_sub):
                    q.append(next_sub)

                    # Update `ans` if `next_sub` is strictly longer,
                    # or if it's the same length and lexicographically larger.
                    if len(next_sub) > len(ans):
                        ans = next_sub
                    elif len(next_sub) == len(ans) and next_sub > ans:
                        ans = next_sub

        return ans