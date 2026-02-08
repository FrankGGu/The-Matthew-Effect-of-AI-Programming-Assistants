from collections import defaultdict

class Solution:
    def countPairs(self, n: int, edges: list[list[int]]) -> list[int]:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        ans = [0] * n

        for i in range(n):
            subtree_sizes = []
            visited = {i}

            def dfs(node, parent):
                size = 0
                for neighbor, weight in graph[node]:
                    if neighbor != parent and neighbor not in visited:
                        visited.add(neighbor)
                        subtree_size = dfs(neighbor, node)
                        ans[i] += (subtree_size // 2000)
                        size += subtree_size
                return size + weight

            total_size = 0
            for neighbor, weight in graph[i]:
                visited = {i}
                visited.add(neighbor)
                subtree_size = dfs(neighbor, i)
                subtree_sizes.append(subtree_size)

        return ans