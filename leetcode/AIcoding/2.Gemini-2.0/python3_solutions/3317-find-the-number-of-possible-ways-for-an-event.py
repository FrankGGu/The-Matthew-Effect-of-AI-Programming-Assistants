class Solution:
    def numberOfWays(self, startPos: int, endPos: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = {}

        def solve(curr_pos, remaining_steps):
            if (curr_pos, remaining_steps) in dp:
                return dp[(curr_pos, remaining_steps)]

            if remaining_steps == 0:
                if curr_pos == endPos:
                    return 1
                else:
                    return 0

            ans = (solve(curr_pos + 1, remaining_steps - 1) + solve(curr_pos - 1, remaining_steps - 1)) % MOD
            dp[(curr_pos, remaining_steps)] = ans
            return ans

        return solve(startPos, k)