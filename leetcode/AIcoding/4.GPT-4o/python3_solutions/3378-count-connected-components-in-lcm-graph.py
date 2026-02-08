class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()
        count = 0

        def dfs(node):
            stack = [node]
            while stack:
                curr = stack.pop()
                for neighbor in graph[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        stack.append(neighbor)

        for i in range(n):
            if i not in visited:
                count += 1
                visited.add(i)
                dfs(i)

        return count