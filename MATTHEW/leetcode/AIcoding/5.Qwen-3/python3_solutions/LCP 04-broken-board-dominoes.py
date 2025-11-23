class Solution:
    def minDominoRotations(self, tops: List[int], bottoms: List[int]) -> int:
        def rotate(target, top, bottom):
            res = 0
            for i in range(len(top)):
                if top[i] == target:
                    continue
                elif bottom[i] == target:
                    res += 1
                else:
                    return float('inf')
            return res

        candidates = set([tops[0], bottoms[0]])
        min_rotations = float('inf')
        for candidate in candidates:
            min_rotations = min(min_rotations, rotate(candidate, tops, bottoms))
        return min_rotations if min_rotations != float('inf') else -1