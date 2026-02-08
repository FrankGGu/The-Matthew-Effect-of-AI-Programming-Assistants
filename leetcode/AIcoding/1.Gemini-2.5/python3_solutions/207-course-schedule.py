class Solution:
    def canFinish(self, numCourses: int, prerequisites: list[list[int]]) -> bool:
        graph = [[] for _ in range(numCourses)]
        for course, prereq in prerequisites:
            graph[prereq].append(course)

        # 0: unvisited, 1: visiting (in current DFS path), 2: visited (finished processing)
        visited = [0] * numCourses

        def dfs(course_node):
            if visited[course_node] == 1:
                return True  # Cycle detected
            if visited[course_node] == 2:
                return False # Already processed, no cycle found from here

            visited[course_node] = 1 # Mark as visiting

            for neighbor in graph[course_node]:
                if dfs(neighbor):
                    return True # Propagate cycle detection

            visited[course_node] = 2 # Mark as visited (finished processing)
            return False # No cycle found from this node

        for i in range(numCourses):
            if dfs(i):
                return False # A cycle was found, cannot finish all courses

        return True # No cycles found, can finish all courses