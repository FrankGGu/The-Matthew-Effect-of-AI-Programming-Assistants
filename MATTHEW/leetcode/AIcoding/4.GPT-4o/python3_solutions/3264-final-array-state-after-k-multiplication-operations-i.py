class Solution:
    def finalArray(self, nums: List[int], operations: List[int]) -> List[int]:
        for op in operations:
            nums = [num * op for num in nums]
        return nums