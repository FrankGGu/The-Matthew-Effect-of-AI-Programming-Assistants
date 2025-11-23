class Solution:
    def checkIfPrerequisite(self, n: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n

        for u, v in prerequisites:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        reachable = [set() for _ in range(n)]
        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                reachable[neighbor].add(node)
                reachable[neighbor].update(reachable[node])
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        result = []
        for u, v in queries:
            result.append(u in reachable[v])

        return result