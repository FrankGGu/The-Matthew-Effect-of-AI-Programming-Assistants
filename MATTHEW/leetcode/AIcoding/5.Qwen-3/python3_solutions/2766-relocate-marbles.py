class Solution:
    def relocateMarbles(self, nums: List[int], moveFrom: int, moveTo: int) -> List[int]:
        if nums.count(moveFrom) == 0:
            return nums
        nums = [num for num in nums if num != moveFrom]
        nums.append(moveTo)
        return sorted(nums)