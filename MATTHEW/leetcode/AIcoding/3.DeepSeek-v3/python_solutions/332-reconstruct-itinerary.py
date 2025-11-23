from collections import defaultdict

class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        graph = defaultdict(list)
        for src, dst in sorted(tickets, reverse=True):
            graph[src].append(dst)

        itinerary = []
        def dfs(node):
            while graph[node]:
                dfs(graph[node].pop())
            itinerary.append(node)

        dfs("JFK")
        return itinerary[::-1]