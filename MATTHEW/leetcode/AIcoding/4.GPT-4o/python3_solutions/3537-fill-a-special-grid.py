def fillGrid(self, A: int, B: int) -> List[List[int]]:
    grid = [[0] * B for _ in range(A)]
    for i in range(A):
        for j in range(B):
            if (i % 2 == 0 and j % 2 == 0) or (i % 2 == 1 and j % 2 == 1):
                grid[i][j] = 1
            else:
                grid[i][j] = 2
    return grid