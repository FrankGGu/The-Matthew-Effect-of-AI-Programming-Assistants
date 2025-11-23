from collections import defaultdict, deque

class Solution:
    def minimumSemesters(self, n: int, relations: List[List[int]]) -> int:
        graph = defaultdict(list)
        indegree = [0] * (n + 1)

        for u, v in relations:
            graph[u].append(v)
            indegree[v] += 1

        queue = deque()
        for i in range(1, n + 1):
            if indegree[i] == 0:
                queue.append(i)

        semesters = 0
        courses_completed = 0

        while queue:
            semesters += 1
            for _ in range(len(queue)):
                course = queue.popleft()
                courses_completed += 1
                for neighbor in graph[course]:
                    indegree[neighbor] -= 1
                    if indegree[neighbor] == 0:
                        queue.append(neighbor)

        return semesters if courses_completed == n else -1