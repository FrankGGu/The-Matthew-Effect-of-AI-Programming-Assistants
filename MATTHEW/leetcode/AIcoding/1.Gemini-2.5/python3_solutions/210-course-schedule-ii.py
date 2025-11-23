import collections

class Solution:
    def findOrder(self, numCourses: int, prerequisites: list[list[int]]) -> list[int]:
        indegree = [0] * numCourses
        adj = collections.defaultdict(list)

        for course, prereq in prerequisites:
            adj[prereq].append(course)
            indegree[course] += 1

        queue = collections.deque()
        for i in range(numCourses):
            if indegree[i] == 0:
                queue.append(i)

        order = []
        while queue:
            node = queue.popleft()
            order.append(node)

            for neighbor in adj[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        if len(order) == numCourses:
            return order
        else:
            return []