class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        n = len(s)
        memo = {}

        def get_compressed_len(count):
            if count == 0:
                return 0
            if count == 1:
                return 1
            if count < 10:
                return 2
            if count < 100:
                return 3
            return 4 # count == 100

        def solve(i, k):
            if k < 0:
                return float('inf')

            if i == n or n - i <= k:
                return 0

            if (i, k) in memo:
                return memo[(i, k)]

            res = float('inf')

            # Option 1: Delete s[i]
            res = min(res, solve(i + 1, k - 1))

            # Option 2: Keep s[i] and form a block starting at s[i]
            # Iterate through all possible end points 'j' for the block starting at 'i'
            # The character for this block is s[i]
            count_same = 0 
            count_diff = 0 
            for j in range(i, n):
                if s[j] == s[i]:
                    count_same += 1
                else:
                    count_diff += 1

                if k >= count_diff:
                    current_block_len = get_compressed_len(count_same)
                    res = min(res, current_block_len + solve(j + 1, k - count_diff))
                else:
                    break

            memo[(i, k)] = res
            return res

        return solve(0, k)