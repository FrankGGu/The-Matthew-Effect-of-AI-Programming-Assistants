class Solution:
    def smallestString(self, s: str, pairs: List[List[int]]) -> str:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in pairs:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * len(s)
        result = list(s)

        def dfs(node, component):
            stack = [node]
            while stack:
                curr = stack.pop()
                if not visited[curr]:
                    visited[curr] = True
                    component.append(curr)
                    for neighbor in graph[curr]:
                        if not visited[neighbor]:
                            stack.append(neighbor)

        for i in range(len(s)):
            if not visited[i]:
                component = []
                dfs(i, component)
                indices = sorted(component)
                chars = sorted(s[j] for j in component)
                for idx, char in zip(indices, chars):
                    result[idx] = char

        return ''.join(result)