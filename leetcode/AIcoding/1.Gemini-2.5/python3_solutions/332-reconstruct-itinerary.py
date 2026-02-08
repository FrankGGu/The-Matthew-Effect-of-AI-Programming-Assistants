import collections

class Solution:
    def findItinerary(self, tickets: list[list[str]]) -> list[str]:
        graph = collections.defaultdict(list)
        for origin, dest in tickets:
            graph[origin].append(dest)

        for origin in graph:
            graph[origin].sort(reverse=True)

        path = []

        def dfs(airport):
            while graph[airport]:
                next_airport = graph[airport].pop()
                dfs(next_airport)
            path.append(airport)

        dfs("JFK")
        return path[::-1]