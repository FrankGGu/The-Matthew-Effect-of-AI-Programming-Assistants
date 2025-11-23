import collections
import math

class Solution:
    def minimumFuelCost(self, n: int, roads: list[list[int]], seats: int) -> int:
        adj = collections.defaultdict(list)
        for u, v in roads:
            adj[u].append(v)
            adj[v].append(u)

        self.total_fuel = 0

        def dfs(node: int, parent: int) -> int:
            people_in_subtree = 1

            for neighbor in adj[node]:
                if neighbor == parent:
                    continue

                people_from_child_subtree = dfs(neighbor, node)
                people_in_subtree += people_from_child_subtree

            if node != 0:
                cars_needed = math.ceil(people_in_subtree / seats)
                self.total_fuel += cars_needed

            return people_in_subtree

        dfs(0, -1)
        return self.total_fuel