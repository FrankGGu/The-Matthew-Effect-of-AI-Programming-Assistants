class Solution:
    def maximumScoreAfterOperations(self, edges: List[List[int]], values: List[int]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        total = sum(values)

        memo = {}

        def dfs(node, parent):
            if node in memo:
                return memo[node]
            sum_children = 0
            for child in tree[node]:
                if child != parent:
                    sum_children += dfs(child, node)
            res = max(values[node], sum_children)
            memo[node] = res
            return res

        min_sum = dfs(0, -1)
        return total - min_sum