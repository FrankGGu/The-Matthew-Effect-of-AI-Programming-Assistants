class Solution:
    def numSubarraysWithSum(self, nums: List[int], goal: int) -> int:
        count = 0
        prefix_sum = {0: 1}
        curr_sum = 0
        for num in nums:
            curr_sum += num
            if curr_sum - goal in prefix_sum:
                count += prefix_sum[curr_sum - goal]
            if curr_sum in prefix_sum:
                prefix_sum[curr_sum] += 1
            else:
                prefix_sum[curr_sum] = 1
        return count