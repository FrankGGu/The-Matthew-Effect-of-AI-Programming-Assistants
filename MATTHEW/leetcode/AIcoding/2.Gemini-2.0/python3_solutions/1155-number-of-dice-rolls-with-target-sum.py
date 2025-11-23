class Solution:
    def numRollsToTarget(self, n: int, k: int, target: int) -> int:
        dp = {}

        def solve(dice_left, target_sum):
            if (dice_left, target_sum) in dp:
                return dp[(dice_left, target_sum)]

            if dice_left == 0:
                if target_sum == 0:
                    return 1
                else:
                    return 0

            if target_sum < dice_left or target_sum > dice_left * k:
                return 0

            count = 0
            for i in range(1, k + 1):
                count = (count + solve(dice_left - 1, target_sum - i)) % (10**9 + 7)

            dp[(dice_left, target_sum)] = count
            return count

        return solve(n, target)