class Solution:
    def findPrefixScore(self, nums: List[int]) -> List[int]:
        n = len(nums)
        max_so_far = -float('inf')
        conversion = [0] * n
        res = [0] * n

        for i in range(n):
            max_so_far = max(max_so_far, nums[i])
            conversion[i] = nums[i] + max_so_far
            res[i] = res[i-1] + conversion[i] if i > 0 else conversion[i]

        return res