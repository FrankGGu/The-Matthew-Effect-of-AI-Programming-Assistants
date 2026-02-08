class Solution:
    def maxDetonatedBombs(self, bombs: List[List[int]]) -> int:
        def canDetonate(b1, b2):
            return (b1[0] - b2[0]) ** 2 + (b1[1] - b2[1]) ** 2 <= b1[2] ** 2

        n = len(bombs)
        graph = [[] for _ in range(n)]

        for i in range(n):
            for j in range(n):
                if i != j and canDetonate(bombs[i], bombs[j]):
                    graph[i].append(j)

        def dfs(node, visited):
            visited.add(node)
            count = 1
            for neighbor in graph[node]:
                if neighbor not in visited:
                    count += dfs(neighbor, visited)
            return count

        max_count = 0
        for i in range(n):
            visited = set()
            max_count = max(max_count, dfs(i, visited))

        return max_count