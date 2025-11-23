from collections import deque

class Solution:
    def checkIfPrerequisite(self, numCourses: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        adj = [[] for _ in range(numCourses)]
        for u, v in prerequisites:
            adj[u].append(v)

        is_prerequisite = [[False] * numCourses for _ in range(numCourses)]

        for i in range(numCourses):
            q = deque()
            q.append(i)

            is_prerequisite[i][i] = True 

            while q:
                curr = q.popleft()

                for neighbor in adj[curr]:
                    if not is_prerequisite[i][neighbor]:
                        is_prerequisite[i][neighbor] = True
                        q.append(neighbor)

        results = []
        for u, v in queries:
            results.append(is_prerequisite[u][v])

        return results