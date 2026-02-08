def oddCells(n: int, m: int, indices: List[List[int]]) -> int:
    row = [0] * n
    col = [0] * m

    for r, c in indices:
        row[r] += 1
        col[c] += 1

    odd_count = 0
    for i in range(n):
        for j in range(m):
            if (row[i] + col[j]) % 2 == 1:
                odd_count += 1

    return odd_count