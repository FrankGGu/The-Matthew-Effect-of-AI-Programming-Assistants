import collections

class Solution:
    def countSubordinates(self, n: int, edges: list[list[int]], headID: int) -> list[int]:
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)

        result = [0] * n

        def dfs(node):
            count = 0
            for neighbor in graph[node]:
                count += 1 + dfs(neighbor)
            result[node] = count
            return count

        dfs(headID)
        return result