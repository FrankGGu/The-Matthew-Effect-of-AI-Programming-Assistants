class Solution:
    def findRotation(self, mat: List[List[int]], target: List[List[int]]) -> bool:
        if mat == target:
            return True
        for _ in range(3):
            mat = [list(row) for row in zip(*mat[::-1])]
            if mat == target:
                return True
        return False