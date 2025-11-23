import heapq

class Solution:
    def findMaximizedCapital(self, k: int, w: int, profits: List[int], capital: List[int]) -> int:
        n = len(profits)
        projects = sorted(zip(capital, profits))
        available_projects = []
        i = 0
        for _ in range(k):
            while i < n and projects[i][0] <= w:
                heapq.heappush(available_projects, -projects[i][1])
                i += 1
            if available_projects:
                w += -heapq.heappop(available_projects)
            else:
                break
        return w