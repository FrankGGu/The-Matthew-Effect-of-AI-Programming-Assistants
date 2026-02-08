from collections import defaultdict
import heapq

class Solution:
    def findItinerary(self, tickets):
        graph = defaultdict(list)
        for src, dest in tickets:
            heapq.heappush(graph[src], dest)

        itinerary = []

        def dfs(airport):
            while graph[airport]:
                dfs(heapq.heappop(graph[airport]))
            itinerary.append(airport)

        dfs("JFK")
        return itinerary[::-1]