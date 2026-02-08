class Solution:
    def countBlackBlocks(self, m: int, n: int, coordinates: List[List[int]]) -> List[int]:
        count = [0] * 5
        blocks = set()
        for x, y in coordinates:
            blocks.add((x, y))

        corner_counts = {}

        for x, y in coordinates:
            for dx in range(-1, 1):
                for dy in range(-1, 1):
                    i, j = x + dx, y + dy
                    if 1 <= i < m and 1 <= j < n:
                        corner = (i, j)
                        if corner not in corner_counts:
                            corner_counts[corner] = 0
                        corner_counts[corner] += 1

        for i, j in corner_counts:
            c = 0
            if (i, j) in blocks:
                c += 1
            if (i + 1, j) in blocks:
                c += 1
            if (i, j + 1) in blocks:
                c += 1
            if (i + 1, j + 1) in blocks:
                c += 1
            count[c] += 1

        total_rectangles = (m - 1) * (n - 1)
        count[0] = total_rectangles - sum(count[1:])

        return count