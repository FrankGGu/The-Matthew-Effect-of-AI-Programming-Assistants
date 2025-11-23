class Solution:
    def maxWeight(self, edges: List[List[int]], values: List[int], k: int) -> int:
        n = len(values)
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        max_weight = -1

        def backtrack(node, visited, path_weight, edges_used):
            nonlocal max_weight
            if edges_used == k:
                max_weight = max(max_weight, path_weight)
                return
            for neighbor, w in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    backtrack(neighbor, visited, path_weight + values[neighbor] + w, edges_used + 1)
                    visited.remove(neighbor)

        for start in range(n):
            backtrack(start, {start}, values[start], 0)

        return max_weight