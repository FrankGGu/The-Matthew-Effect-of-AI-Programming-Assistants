import heapq

class Solution:
    def findMaximizedCapital(self, k: int, w: int, profits: list[int], capital: list[int]) -> int:
        n = len(profits)

        # Create a list of (capital, profit) pairs and sort them by capital
        projects = []
        for i in range(n):
            projects.append((capital[i], profits[i]))
        projects.sort()

        current_capital = w

        # Max-heap to store profits of affordable projects
        # Python's heapq is a min-heap, so we store negative profits
        affordable_profits_heap = [] 

        project_idx = 0

        for _ in range(k):
            # Add all projects that can be afforded with current_capital to the max-heap
            while project_idx < n and projects[project_idx][0] <= current_capital:
                heapq.heappush(affordable_profits_heap, -projects[project_idx][1])
                project_idx += 1

            # If no projects can be afforded, we can't do anything more
            if not affordable_profits_heap:
                break

            # Take the project with the maximum profit from the affordable projects
            current_capital += -heapq.heappop(affordable_profits_heap)

        return current_capital