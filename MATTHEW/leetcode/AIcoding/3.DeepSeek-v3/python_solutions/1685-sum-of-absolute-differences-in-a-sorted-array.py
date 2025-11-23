class Solution:
    def getSumAbsoluteDifferences(self, nums: List[int]) -> List[int]:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        res = []
        for i in range(n):
            left_sum = nums[i] * i - prefix[i]
            right_sum = (prefix[n] - prefix[i + 1]) - nums[i] * (n - 1 - i)
            res.append(left_sum + right_sum)
        return res