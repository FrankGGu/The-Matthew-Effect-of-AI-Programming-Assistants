class Solution:
    def countBlackBlocks(self, m: int, n: int, coordinates: List[List[int]]) -> List[int]:
        from collections import defaultdict

        block_counts = defaultdict(int)
        res = [0] * 5

        for x, y in coordinates:
            for i in [x, x - 1]:
                for j in [y, y - 1]:
                    if 0 <= i < m - 1 and 0 <= j < n - 1:
                        block_counts[(i, j)] += 1

        for count in block_counts.values():
            res[count] += 1

        total_blocks = (m - 1) * (n - 1)
        res[0] = total_blocks - sum(res[1:])

        return res