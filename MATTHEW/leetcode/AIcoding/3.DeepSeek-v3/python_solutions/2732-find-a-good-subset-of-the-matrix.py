class Solution:
    def goodSubsetofBinaryMatrix(self, grid: List[List[int]]) -> List[int]:
        from collections import defaultdict
        m, n = len(grid), len(grid[0])
        mask_to_row = defaultdict(int)

        for i in range(m):
            mask = 0
            for j in range(n):
                if grid[i][j] == 1:
                    mask |= (1 << j)
            if mask == 0:
                return [i]
            mask_to_row[mask] = i

        masks = list(mask_to_row.keys())
        for i in range(len(masks)):
            for j in range(i + 1, len(masks)):
                if (masks[i] & masks[j]) == 0:
                    x, y = mask_to_row[masks[i]], mask_to_row[masks[j]]
                    return [min(x, y), max(x, y)]

        return []