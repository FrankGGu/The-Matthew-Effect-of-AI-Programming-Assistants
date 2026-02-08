class Solution:
    def removeDuplicateRows(self, matrix: List[List[int]]) -> List[List[int]]:
        return list(map(list, set(map(tuple, matrix))))