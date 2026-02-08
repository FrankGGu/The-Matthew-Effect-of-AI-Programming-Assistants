import heapq

def maxWeightedKEdgePath(n: int, edges: list[list[int]], k: int) -> int:
    adj = [[] for _ in range(n)]
    for u, v, w in edges:
        adj[u].append((v, w))

    dp = {}

    def solve(node, remaining_edges):
        if (node, remaining_edges) in dp:
            return dp[(node, remaining_edges)]

        if remaining_edges == 0:
            return 0

        max_path = float('-inf')
        for neighbor, weight in adj[node]:
            path_len = solve(neighbor, remaining_edges - 1)
            if path_len != float('-inf'):
                max_path = max(max_path, weight + path_len)

        dp[(node, remaining_edges)] = max_path
        return max_path

    result = float('-inf')
    for start_node in range(n):
        result = max(result, solve(start_node, k))

    return result if result != float('-inf') else -1