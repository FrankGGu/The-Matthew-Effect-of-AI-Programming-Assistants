class Solution:
    def findSpecialSubstringOfLengthK(self, s: str, k: int) -> int:
        n = len(s)
        if k > n or k <= 0:
            return 0

        left_run = [0] * n
        right_run = [0] * n

        # Calculate left_run: length of consecutive identical characters ending at index i
        left_run[0] = 1
        for i in range(1, n):
            if s[i] == s[i-1]:
                left_run[i] = left_run[i-1] + 1
            else:
                left_run[i] = 1

        # Calculate right_run: length of consecutive identical characters starting at index i
        right_run[n-1] = 1
        for i in range(n-2, -1, -1):
            if s[i] == s[i+1]:
                right_run[i] = right_run[i+1] + 1
            else:
                right_run[i] = 1

        count = 0
        for i in range(n - k + 1):
            # Consider the substring s[i : i+k]

            # Check for Type 1: All characters in the substring are the same
            # This means the run of identical characters starting at `i` must be at least `k`
            if right_run[i] >= k:
                count += 1
                # A substring cannot be both Type 1 and Type 2 by definition (middle char must be different)
                continue 

            # Check for Type 2: All characters except the middle one are the same
            # This is only possible if k is odd
            if k % 2 == 1:
                mid_idx = i + k // 2

                # The character at the start of the substring must be the same as the character at the end
                # And the middle character must be different from them
                if s[i] == s[i+k-1] and s[i] != s[mid_idx]:
                    # The run of identical characters starting at `i` must extend at least `k//2` characters
                    # (i.e., s[i...mid_idx-1] are all s[i])
                    # The run of identical characters ending at `i+k-1` must extend at least `k//2` characters
                    # (i.e., s[mid_idx+1...i+k-1] are all s[i+k-1], which is s[i])
                    if right_run[i] >= k // 2 and left_run[i+k-1] >= k // 2:
                        count += 1

        return count