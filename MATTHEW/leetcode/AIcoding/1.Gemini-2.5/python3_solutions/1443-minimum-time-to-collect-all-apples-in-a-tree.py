from collections import defaultdict

class Solution:
    def minTime(self, n: int, edges: list[list[int]], hasApple: list[bool]) -> int:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        total_time = [0]

        def dfs(u: int, p: int) -> bool:
            has_apple_in_subtree = hasApple[u]

            for v in adj[u]:
                if v == p:
                    continue

                child_has_apple = dfs(v, u)

                if child_has_apple:
                    total_time[0] += 2
                    has_apple_in_subtree = True

            return has_apple_in_subtree

        dfs(0, -1)

        return total_time[0]