class Solution:
    def minimumFuelCost(self, roads: List[List[int]], seats: int) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            total_people = 1
            fuel_cost = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    people, cost = dfs(neighbor, node)
                    total_people += people
                    fuel_cost += cost
            if node != 0:
                fuel_cost += (total_people + seats - 1) // seats
            return total_people, fuel_cost

        return dfs(0, -1)[1]