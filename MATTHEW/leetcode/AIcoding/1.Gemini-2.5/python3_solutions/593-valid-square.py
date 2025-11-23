import collections

class Solution:
    def validSquare(self, p1: list[int], p2: list[int], p3: list[int], p4: list[int]) -> bool:
        def distSq(pA, pB):
            return (pA[0] - pB[0])**2 + (pA[1] - pB[1])**2

        points = [p1, p2, p3, p4]

        distances = []
        for i in range(4):
            for j in range(i + 1, 4):
                d = distSq(points[i], points[j])
                distances.append(d)

        counts = collections.Counter(distances)

        if len(counts) != 2:
            return False

        sorted_distances_items = sorted(counts.items())

        side_sq, side_count = sorted_distances_items[0]
        diag_sq, diag_count = sorted_distances_items[1]

        return side_sq > 0 and side_count == 4 and diag_count == 2 and diag_sq == 2 * side_sq