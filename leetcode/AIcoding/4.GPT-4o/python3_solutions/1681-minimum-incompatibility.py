from itertools import combinations

class Solution:
    def minimumIncompatibility(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n % k != 0:
            return -1

        m = n // k
        all_combinations = list(combinations(nums, m))
        valid_combinations = []

        for comb in all_combinations:
            if len(set(comb)) == m:
                valid_combinations.append(comb)

        dp = {}

        def dfs(used_mask):
            if used_mask == (1 << n) - 1:
                return 0

            if used_mask in dp:
                return dp[used_mask]

            min_incompatibility = float('inf')
            for comb in valid_combinations:
                mask = 0
                for num in comb:
                    idx = nums.index(num)
                    mask |= (1 << idx)
                    nums[idx] = float('inf')

                if mask & used_mask == 0:
                    incompatibility = max(comb) - min(comb)
                    min_incompatibility = min(min_incompatibility, incompatibility + dfs(used_mask | mask))

                for num in comb:
                    idx = nums.index(float('inf'))
                    nums[idx] = num

            dp[used_mask] = min_incompatibility
            return min_incompatibility

        result = dfs(0)
        return result if result != float('inf') else -1