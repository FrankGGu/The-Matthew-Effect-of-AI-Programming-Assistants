class Solution:
    def arrayChange(self, nums: List[int], operations: List[List[int]]) -> List[int]:
        num_map = {num: i for i, num in enumerate(nums)}
        for operation in operations:
            nums[num_map[operation[0]]] = operation[1]
            num_map[operation[1]] = num_map[operation[0]]
            del num_map[operation[0]]
        return nums