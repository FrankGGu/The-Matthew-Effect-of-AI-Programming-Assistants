class Solution:
    def getAncestors(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        graph = [[] for _ in range(n)]
        in_degree = [0] * n
        ancestors = [set() for _ in range(n)]

        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        while queue:
            u = queue.popleft()
            for v in graph[u]:
                ancestors[v].add(u)
                ancestors[v].update(ancestors[u])
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    queue.append(v)

        return [sorted(list(s)) for s in ancestors]