class Solution:
    def assignGroups(self, n: int, constraints: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * (n + 1)
        color = [0] * (n + 1)

        for a, b in constraints:
            graph[a].append(b)
            in_degree[b] += 1

        q = deque()
        for i in range(1, n + 1):
            if in_degree[i] == 0:
                q.append(i)
                color[i] = 1

        while q:
            u = q.popleft()
            for v in graph[u]:
                if color[v] == 0:
                    color[v] = 3 - color[u]
                elif color[v] == color[u]:
                    return []
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        if any(in_degree[i] > 0 for i in range(1, n + 1)):
            return []

        return color[1:n + 1]