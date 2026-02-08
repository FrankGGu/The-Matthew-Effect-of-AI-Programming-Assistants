class Solution:
    def spiralMatrixIII(self, rows: int, cols: int, rStart: int, cStart: int) -> List[List[int]]:
        res = []
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        step = 0
        dir_idx = 0
        res.append([rStart, cStart])
        if len(res) == rows * cols:
            return res
        while True:
            if dir_idx % 2 == 0:
                step += 1
            for _ in range(step):
                rStart += directions[dir_idx][0]
                cStart += directions[dir_idx][1]
                if 0 <= rStart < rows and 0 <= cStart < cols:
                    res.append([rStart, cStart])
                    if len(res) == rows * cols:
                        return res
            dir_idx = (dir_idx + 1) % 4