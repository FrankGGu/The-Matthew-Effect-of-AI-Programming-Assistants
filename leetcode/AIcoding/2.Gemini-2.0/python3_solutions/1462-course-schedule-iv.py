class Solution:
    def checkIfPrerequisite(self, numCourses: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        graph = [[] for _ in range(numCourses)]
        in_degree = [0] * numCourses
        is_reachable = [[False] * numCourses for _ in range(numCourses)]

        for u, v in prerequisites:
            graph[u].append(v)
            in_degree[v] += 1

        q = deque()
        for i in range(numCourses):
            if in_degree[i] == 0:
                q.append(i)

        while q:
            u = q.popleft()
            for v in graph[u]:
                is_reachable[u][v] = True
                for i in range(numCourses):
                    if is_reachable[i][u]:
                        is_reachable[i][v] = True
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        result = []
        for u, v in queries:
            result.append(is_reachable[u][v])

        return result