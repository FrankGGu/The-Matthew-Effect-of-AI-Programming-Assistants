class Solution:
    def eventualSafeNodes(self, graph: List[List[int]]) -> List[int]:
        n = len(graph)
        safe = [False] * n
        visited = [False] * n
        in_stack = [False] * n

        def dfs(node):
            visited[node] = True
            in_stack[node] = True

            for neighbor in graph[node]:
                if in_stack[neighbor]:
                    return False
                if not visited[neighbor] and not dfs(neighbor):
                    return False

            in_stack[node] = False
            safe[node] = True
            return True

        for i in range(n):
            if not visited[i]:
                dfs(i)

        result = []
        for i in range(n):
            if safe[i]:
                result.append(i)

        return result