class Solution:
    def countSubarrays(self, nums: list[int], k: int) -> int:
        n = len(nums)

        transformed_nums = [0] * n
        for i in range(n):
            if nums[i] > k:
                transformed_nums[i] = 1
            elif nums[i] < k:
                transformed_nums[i] = -1
            else:
                transformed_nums[i] = 0

        ans = 0
        current_sum = 0

        prefix_sum_counts = {0: 1}

        for i in range(n):
            current_sum += transformed_nums[i]

            ans += prefix_sum_counts.get(current_sum, 0)
            ans += prefix_sum_counts.get(current_sum - 1, 0)

            prefix_sum_counts[current_sum] = prefix_sum_counts.get(current_sum, 0) + 1

        return ans