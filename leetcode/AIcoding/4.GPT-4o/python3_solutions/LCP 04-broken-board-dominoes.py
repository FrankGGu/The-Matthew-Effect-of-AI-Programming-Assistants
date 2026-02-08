def dominoes(N: int, M: int, board: List[str]) -> int:
    from collections import defaultdict

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        rootX = find(x)
        rootY = find(y)
        if rootX != rootY:
            parent[rootY] = rootX

    parent = {i: i for i in range(N * M)}
    total_dominoes = 0

    for i in range(N):
        for j in range(M):
            if board[i][j] == '.':
                total_dominoes += 1
                if j + 1 < M and board[i][j + 1] == '.':
                    union(i * M + j, i * M + j + 1)
                if i + 1 < N and board[i + 1][j] == '.':
                    union(i * M + j, (i + 1) * M + j)

    root_count = len(set(find(i) for i in range(N * M) if board[i // M][i % M] == '.'))

    return total_dominoes - root_count