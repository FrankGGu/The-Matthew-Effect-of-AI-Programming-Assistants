class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
        from collections import defaultdict

        def dfs(node):
            component = []
            stack = [node]
            while stack:
                curr = stack.pop()
                if curr not in visited:
                    visited.add(curr)
                    component.append(curr)
                    for neighbor in graph[curr]:
                        if neighbor not in visited:
                            stack.append(neighbor)
            return component

        graph = defaultdict(list)
        for u, v in pairs:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()
        result = list(s)

        for i in range(len(s)):
            if i not in visited:
                component = dfs(i)
                chars = sorted(result[j] for j in component)
                component.sort()
                for idx, pos in enumerate(component):
                    result[pos] = chars[idx]

        return ''.join(result)