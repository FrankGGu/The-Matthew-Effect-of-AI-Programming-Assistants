from collections import defaultdict

def longestSpecialPath(n: int, edges: list[list[int]], values: list[int]) -> int:
    adj = defaultdict(list)
    for u, v in edges:
        adj[u].append(v)
        adj[v].append(u)

    def gcd(a, b):
        if b == 0:
            return a
        return gcd(b, a % b)

    def dfs(node, parent):
        max_len = 0
        for neighbor in adj[node]:
            if neighbor != parent:
                if gcd(values[node], values[neighbor]) > 1:
                    max_len = max(max_len, 1 + dfs(neighbor, node))
                else:
                    max_len = max(max_len, dfs(neighbor, node))
        return max_len

    max_path = 0
    for i in range(n):
        max_path = max(max_path, dfs(i, -1))

    return max_path