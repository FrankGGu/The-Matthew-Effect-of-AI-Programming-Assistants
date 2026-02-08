import collections

class Solution:
    def maxPriceSum(self, n: int, prices: list[int], edges: list[list[int]]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        total_sum = sum(prices)
        max_diff = 0

        def dfs(u, parent):
            nonlocal max_diff
            current_subtree_sum = prices[u]
            for v in adj[u]:
                if v != parent:
                    current_subtree_sum += dfs(v, u)

            if current_subtree_sum != total_sum:
                max_diff = max(max_diff, abs(2 * current_subtree_sum - total_sum))

            return current_subtree_sum

        dfs(0, -1) 

        return max_diff