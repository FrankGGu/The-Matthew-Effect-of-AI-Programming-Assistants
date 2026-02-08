from collections import deque

class Solution:
    def findOrder(self, numCourses: int, prerequisites: list[list[int]]) -> list[int]:
        in_degree = [0] * numCourses
        adj = [[] for _ in range(numCourses)]

        for course, prereq in prerequisites:
            adj[prereq].append(course)
            in_degree[course] += 1

        queue = deque()
        for i in range(numCourses):
            if in_degree[i] == 0:
                queue.append(i)

        result = []
        while queue:
            u = queue.popleft()
            result.append(u)

            for v in adj[u]:
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    queue.append(v)

        if len(result) == numCourses:
            return result
        else:
            return []