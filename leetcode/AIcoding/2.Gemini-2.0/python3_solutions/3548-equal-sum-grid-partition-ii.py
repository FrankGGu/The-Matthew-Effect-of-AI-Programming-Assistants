def equalSumGrid(grid: list[list[int]]) -> int:
    n = len(grid)
    m = len(grid[0])
    total_sum = sum(sum(row) for row in grid)
    if total_sum % 2 != 0:
        return 0
    target_sum = total_sum // 2
    count = 0
    for i in range(n):
        row_sum = sum(grid[i])
        if row_sum == target_sum:
            count += 1
        else:
            col_sum = 0
            for j in range(m):
                col_sum += grid[i][j]
                remaining_row_sum = row_sum - col_sum
                if col_sum == target_sum or remaining_row_sum == target_sum:
                    count += 1
                    break
    return count