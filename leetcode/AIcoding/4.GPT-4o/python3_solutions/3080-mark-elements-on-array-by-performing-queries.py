class Solution:
    def arrayChange(self, nums: List[int], operations: List[List[int]]) -> List[int]:
        num_to_index = {num: i for i, num in enumerate(nums)}
        for old, new in operations:
            index = num_to_index.pop(old)
            nums[index] = new
            num_to_index[new] = index
        return nums