class Solution:
    def findDifferentBinaryString(self, nums: List[str]) -> str:
        n = len(nums)
        result = ""
        for i in range(n):
            if nums[i][i] == '0':
                result += '1'
            else:
                result += '0'
        return result