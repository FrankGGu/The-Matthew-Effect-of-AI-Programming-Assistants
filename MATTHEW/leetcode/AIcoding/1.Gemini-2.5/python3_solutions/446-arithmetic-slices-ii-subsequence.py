from collections import defaultdict

class Solution:
    def numberOfArithmeticSlices(self, nums: list[int]) -> int:
        n = len(nums)
        ans = 0

        # dp[i] is a dictionary where dp[i][diff] stores the count of 
        # arithmetic subsequences of length at least 2, ending at index i, 
        # with common difference 'diff'.
        dp = [defaultdict(int) for _ in range(n)]

        for i in range(n):
            for j in range(i):
                # Calculate the difference between nums[i] and nums[j]
                diff = nums[i] - nums[j]

                # count_j_diff represents the number of arithmetic subsequences 
                # of length at least 2, ending at index j, with this 'diff'.
                count_j_diff = dp[j][diff]

                # When we extend these 'count_j_diff' subsequences by nums[i],
                # they form new arithmetic subsequences of length at least 3.
                # These are valid arithmetic slices, so add them to the total answer.
                ans += count_j_diff

                # Update dp[i][diff]:
                # 1. Add 1 for the new arithmetic subsequence of length 2: (nums[j], nums[i]).
                # 2. Add 'count_j_diff' for all subsequences of length >= 2 ending at j 
                #    with 'diff', which are now extended by nums[i] to form length >= 3 subsequences.
                dp[i][diff] += (count_j_diff + 1)

        return ans