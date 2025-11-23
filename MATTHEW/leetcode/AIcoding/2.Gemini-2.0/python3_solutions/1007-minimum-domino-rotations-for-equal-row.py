class Solution:
    def minDominoRotations(self, tops: list[int], bottoms: list[int]) -> int:
        n = len(tops)
        for target in [tops[0], bottoms[0]]:
            rotations_top = 0
            rotations_bottom = 0
            valid = True
            for i in range(n):
                if tops[i] != target and bottoms[i] != target:
                    valid = False
                    break
                elif tops[i] != target:
                    rotations_top += 1
                elif bottoms[i] != target:
                    rotations_bottom += 1
            if valid:
                return min(rotations_top, rotations_bottom)
        return -1