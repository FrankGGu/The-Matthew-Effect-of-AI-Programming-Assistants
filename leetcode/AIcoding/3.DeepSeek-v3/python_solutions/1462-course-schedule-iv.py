class Solution:
    def checkIfPrerequisite(self, numCourses: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        graph = [[] for _ in range(numCourses)]
        in_degree = [0] * numCourses
        pre_map = [set() for _ in range(numCourses)]

        for u, v in prerequisites:
            graph[u].append(v)
            in_degree[v] += 1

        queue = []
        for i in range(numCourses):
            if in_degree[i] == 0:
                queue.append(i)

        while queue:
            u = queue.pop(0)
            for v in graph[u]:
                pre_map[v].add(u)
                pre_map[v].update(pre_map[u])
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    queue.append(v)

        res = []
        for u, v in queries:
            res.append(u in pre_map[v])
        return res