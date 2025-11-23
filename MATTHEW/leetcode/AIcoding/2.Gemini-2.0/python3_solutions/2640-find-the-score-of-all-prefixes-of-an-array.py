class Solution:
    def findPrefixScore(self, nums: List[int]) -> List[int]:
        n = len(nums)
        max_num = 0
        prefix_sum = 0
        result = []
        for i in range(n):
            max_num = max(max_num, nums[i])
            prefix_sum += nums[i] + max_num
            result.append(prefix_sum)
        return result