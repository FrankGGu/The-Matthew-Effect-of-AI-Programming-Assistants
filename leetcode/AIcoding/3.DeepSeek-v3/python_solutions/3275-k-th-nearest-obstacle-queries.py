import bisect

class Solution:
    def kthNearest(self, obstacles: List[int], queries: List[List[int]]) -> List[int]:
        obstacles_sorted = sorted(obstacles)
        res = []
        for x, k in queries:
            idx = bisect.bisect_left(obstacles_sorted, x)
            candidates = []
            left, right = idx - 1, idx
            for _ in range(k):
                if left >= 0 and right < len(obstacles_sorted):
                    if x - obstacles_sorted[left] <= obstacles_sorted[right] - x:
                        candidates.append(obstacles_sorted[left])
                        left -= 1
                    else:
                        candidates.append(obstacles_sorted[right])
                        right += 1
                elif left >= 0:
                    candidates.append(obstacles_sorted[left])
                    left -= 1
                elif right < len(obstacles_sorted):
                    candidates.append(obstacles_sorted[right])
                    right += 1
                else:
                    break
            res.append(candidates[-1])
        return res