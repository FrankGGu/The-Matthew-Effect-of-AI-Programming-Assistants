class Solution:
    def minimumFuelCost(self, roads: List[List[int]], seats: int) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        self.fuel = 0

        def dfs(node, parent):
            people = 1
            for neighbor in graph[node]:
                if neighbor != parent:
                    people += dfs(neighbor, node)
            if node != 0:
                self.fuel += (people + seats - 1) // seats
            return people

        dfs(0, -1)
        return self.fuel