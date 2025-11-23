class Solution:
    def maxKDivisibleComponents(self, n: int, edges: list[list[int]], values: list[int], k: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        total_components = [0]

        def dfs(u, parent):
            current_sum = values[u]

            for v in adj[u]:
                if v == parent:
                    continue

                child_sum_mod_k = dfs(v, u)
                current_sum += child_sum_mod_k

            if current_sum % k == 0:
                total_components[0] += 1
                return 0
            else:
                return current_sum % k

        dfs(0, -1)

        return total_components[0]