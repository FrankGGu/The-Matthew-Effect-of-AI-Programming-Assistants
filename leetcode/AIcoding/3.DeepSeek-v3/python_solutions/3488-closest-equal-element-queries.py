import bisect

class Solution:
    def closestEqualElement(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        pos = {}
        for idx, num in enumerate(arr):
            if num not in pos:
                pos[num] = []
            pos[num].append(idx)

        res = []
        for l, r, x in queries:
            if x not in pos:
                res.append(-1)
                continue
            indices = pos[x]
            i = bisect.bisect_left(indices, l)
            candidates = []
            if i > 0:
                candidates.append(indices[i-1])
            if i < len(indices):
                candidates.append(indices[i])
            min_dist = float('inf')
            best = -1
            for idx in candidates:
                if l <= idx <= r:
                    dist = abs(idx - l) + abs(idx - r)
                    if dist < min_dist:
                        min_dist = dist
                        best = idx
            res.append(best)
        return res