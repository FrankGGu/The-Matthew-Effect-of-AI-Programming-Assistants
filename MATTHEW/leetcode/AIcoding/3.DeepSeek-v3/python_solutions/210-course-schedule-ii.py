from collections import deque

class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        adj = [[] for _ in range(numCourses)]
        in_degree = [0] * numCourses
        for course, pre in prerequisites:
            adj[pre].append(course)
            in_degree[course] += 1

        queue = deque()
        for course in range(numCourses):
            if in_degree[course] == 0:
                queue.append(course)

        result = []
        while queue:
            pre = queue.popleft()
            result.append(pre)
            for course in adj[pre]:
                in_degree[course] -= 1
                if in_degree[course] == 0:
                    queue.append(course)

        return result if len(result) == numCourses else []