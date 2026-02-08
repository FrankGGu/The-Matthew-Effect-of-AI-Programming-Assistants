class Solution:
    def crackSafe(self, n: int, k: int) -> str:
        if n == 1:
            return ''.join(str(i) for i in range(k))
        visited = set()
        res = []
        def dfs(node):
            for x in map(str, range(k)):
                neighbor = node + x
                if neighbor not in visited:
                    visited.add(neighbor)
                    dfs(neighbor[1:])
                    res.append(x)
        start = '0' * (n - 1)
        dfs(start)
        return ''.join(res) + start