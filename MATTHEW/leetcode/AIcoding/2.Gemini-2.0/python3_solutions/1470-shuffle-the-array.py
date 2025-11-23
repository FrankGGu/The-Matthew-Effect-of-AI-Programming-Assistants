class Solution:
    def shuffle(self, nums: list[int], n: int) -> list[int]:
        res = []
        for i in range(n):
            res.append(nums[i])
            res.append(nums[i + n])
        return res