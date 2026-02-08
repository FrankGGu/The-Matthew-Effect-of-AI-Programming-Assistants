class Solution:
    def optimalDivision(self, nums: list[int]) -> str:
        n = len(nums)
        if n == 1:
            return str(nums[0])
        elif n == 2:
            return str(nums[0]) + "/" + str(nums[1])
        else:
            result = [str(nums[0]), "/("]
            for i in range(1, n):
                result.append(str(nums[i]))
                if i < n - 1:
                    result.append("/")
            result.append(")")
            return "".join(result)