class Solution:
    def minimumFuelCost(self, roads: List[List[int]], seats: int) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for a, b in roads:
            graph[a].append(b)
            graph[b].append(a)

        self.res = 0

        def dfs(node, parent):
            people = 1
            for neighbor in graph[node]:
                if neighbor == parent:
                    continue
                p = dfs(neighbor, node)
                people += p
                self.res += (p + seats - 1) // seats
            return people

        dfs(0, -1)
        return self.res