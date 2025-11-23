import math

class Solution:
    def getCoprimes(self, nums: list[int], edges: list[list[int]]) -> list[int]:
        n = len(nums)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = [-1] * n

        path_tracker = [(-1, -1)] * 51 

        def dfs(u, p, d):
            nonlocal ans, path_tracker

            val_u = nums[u]
            best_ancestor_node = -1
            max_ancestor_depth = -1

            for k in range(1, 51):
                if math.gcd(val_u, k) == 1:
                    if path_tracker[k][0] != -1:
                        if path_tracker[k][1] > max_ancestor_depth:
                            max_ancestor_depth = path_tracker[k][1]
                            best_ancestor_node = path_tracker[k][0]

            ans[u] = best_ancestor_node

            original_tracker_state_for_val_u = path_tracker[val_u]
            path_tracker[val_u] = (u, d)

            for v in adj[u]:
                if v != p:
                    dfs(v, u, d + 1)

            path_tracker[val_u] = original_tracker_state_for_val_u

        dfs(0, -1, 0)
        return ans