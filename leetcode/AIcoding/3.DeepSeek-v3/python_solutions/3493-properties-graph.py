class Solution:
    def propertyGraph(self, n: int, edges: List[List[int]], property: List[int]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        res = [0] * n
        for i in range(n):
            visited = [False] * n
            q = deque()
            q.append((i, 0))
            visited[i] = True
            total = 0

            while q:
                node, dist = q.popleft()
                if dist > 0 and property[node] == property[i]:
                    total += dist

                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        q.append((neighbor, dist + 1))

            res[i] = total

        return res