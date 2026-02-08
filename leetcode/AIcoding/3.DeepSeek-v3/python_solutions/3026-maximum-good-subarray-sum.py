class Solution:
    def maximumSubarraySum(self, nums: List[int], k: int) -> int:
        prefix_sum = 0
        prefix_sums = {0: -1}
        max_sum = -float('inf')

        for i, num in enumerate(nums):
            prefix_sum += num
            target1 = prefix_sum - k
            target2 = prefix_sum + k

            if target1 in prefix_sums:
                current_sum = prefix_sum - target1
                if current_sum > max_sum:
                    max_sum = current_sum

            if target2 in prefix_sums:
                current_sum = prefix_sum - target2
                if abs(current_sum) == k and current_sum > max_sum:
                    max_sum = current_sum

            if prefix_sum not in prefix_sums or i < prefix_sums[prefix_sum]:
                prefix_sums[prefix_sum] = i

        return max_sum if max_sum != -float('inf') else 0