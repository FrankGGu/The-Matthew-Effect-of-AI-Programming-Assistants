from typing import List
import collections

class Solution:
    def checkIfPrerequisite(self, numCourses: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        graph = [[] for _ in range(numCourses)]
        in_degree = [0] * numCourses
        for pre, course in prerequisites:
            graph[pre].append(course)
            in_degree[course] += 1

        order = []
        queue = collections.deque([i for i in range(numCourses) if in_degree[i] == 0])
        while queue:
            node = queue.popleft()
            order.append(node)
            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        course_to_index = {course: idx for idx, course in enumerate(order)}
        reachable = [[False] * numCourses for _ in range(numCourses)]

        for i in range(numCourses):
            for j in range(i + 1, numCourses):
                if course_to_index[i] < course_to_index[j]:
                    reachable[i][j] = True

        result = []
        for u, v in queries:
            result.append(reachable[u][v])
        return result