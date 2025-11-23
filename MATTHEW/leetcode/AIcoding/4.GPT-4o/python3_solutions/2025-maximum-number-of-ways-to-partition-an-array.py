class Solution:
    def waysToPartition(self, nums: List[int]) -> int:
        total_sum = sum(nums)
        prefix_sum = 0
        count = 0
        sum_count = defaultdict(int)

        for num in nums:
            prefix_sum += num
            sum_count[prefix_sum] += 1

        prefix_sum = 0
        for i in range(len(nums) - 1):
            prefix_sum += nums[i]
            if prefix_sum * 2 == total_sum:
                count += 1
            if total_sum - prefix_sum in sum_count:
                count += sum_count[total_sum - prefix_sum]
            sum_count[prefix_sum] -= 1

        return count