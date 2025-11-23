class Solution:
    def optimalDivision(self, nums: List[int]) -> str:
        n = len(nums)
        if n == 1:
            return str(nums[0])
        if n == 2:
            return str(nums[0]) + "/" + str(nums[1])

        res = str(nums[0]) + "/("
        for i in range(1, n):
            res += str(nums[i])
            if i < n - 1:
                res += "/"
        res += ")"
        return res