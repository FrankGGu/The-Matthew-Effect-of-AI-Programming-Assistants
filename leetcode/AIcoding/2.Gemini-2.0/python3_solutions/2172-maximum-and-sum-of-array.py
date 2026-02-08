class Solution:
    def maximumANDSum(self, nums: List[int], numSlots: int) -> int:
        n = len(nums)
        m = numSlots
        dp = {}

        def solve(idx, slots):
            if idx == n:
                return 0

            state = (idx, tuple(slots))
            if state in dp:
                return dp[state]

            ans = 0
            for i in range(m):
                if slots[i] > 0:
                    new_slots = list(slots)
                    new_slots[i] -= 1
                    ans = max(ans, (nums[idx] & (i + 1)) + solve(idx + 1, tuple(new_slots)))

            dp[state] = ans
            return ans

        initial_slots = (2,) * m
        return solve(0, initial_slots)