class Solution:
    def subsets(self, nums: list[int]) -> list[list[int]]:
        res = [[]]
        for num in nums:
            current_len = len(res)
            for i in range(current_len):
                res.append(res[i] + [num])
        return res