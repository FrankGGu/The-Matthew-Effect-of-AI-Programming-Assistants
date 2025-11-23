class Solution:
    def finalArray(self, nums: List[int], k: int) -> List[int]:
        for i in range(len(nums)):
            if k % 2 == 0:
                nums[i] *= 2 ** (k // 2)
            else:
                nums[i] *= 2 ** (k // 2)
                if i % 2 == 0:
                    nums[i] *= 2
        return nums