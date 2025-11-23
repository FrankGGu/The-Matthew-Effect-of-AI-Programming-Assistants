import bisect

class Solution:
    def findBeautifulIndices(self, s: str, a: str, b: str, k: int) -> list[int]:
        idx_a = []
        pos = s.find(a, 0)
        while pos != -1:
            idx_a.append(pos)
            pos = s.find(a, pos + 1)

        idx_b = []
        pos = s.find(b, 0)
        while pos != -1:
            idx_b.append(pos)
            pos = s.find(b, pos + 1)

        beautiful_indices = set()

        for i in idx_a:
            left_bound_for_j = i - k

            idx = bisect.bisect_left(idx_b, left_bound_for_j)

            if idx < len(idx_b) and idx_b[idx] <= i + k:
                beautiful_indices.add(i)

        return sorted(list(beautiful_indices))