def crackSafe(n: int, k: int) -> str:
    res = []
    visited = set()
    total = k ** n

    def dfs(node):
        for x in range(k):
            edge = node + str(x)
            if edge not in visited:
                visited.add(edge)
                dfs(edge[n-1:])
                res.append(str(x))

    dfs('0' * (n - 1))
    return ''.join(res) + '0' * (n - 1)