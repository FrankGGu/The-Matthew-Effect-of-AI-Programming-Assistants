class Solution:
    def subarraySum(self, nums: list[int], k: int) -> int:
        count = 0
        current_sum = 0
        prefix_sum_counts = {0: 1}

        for num in nums:
            current_sum += num

            if (current_sum - k) in prefix_sum_counts:
                count += prefix_sum_counts[current_sum - k]

            prefix_sum_counts[current_sum] = prefix_sum_counts.get(current_sum, 0) + 1

        return count