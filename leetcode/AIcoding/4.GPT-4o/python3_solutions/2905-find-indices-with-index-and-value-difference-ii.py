class Solution:
    def findIndices(self, nums: List[int], target: int) -> List[int]:
        index_map = {}
        result = []
        for i, num in enumerate(nums):
            if num - i in index_map:
                result.append(index_map[num - i])
            index_map[num - i] = i
        return result