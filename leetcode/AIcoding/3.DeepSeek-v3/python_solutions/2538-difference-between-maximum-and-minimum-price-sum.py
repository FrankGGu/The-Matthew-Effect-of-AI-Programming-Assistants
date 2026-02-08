class Solution:
    def maxOutput(self, n: int, edges: List[List[int]], price: List[int]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        res = 0

        def dfs(node, parent):
            nonlocal res
            max1 = 0
            max2 = 0
            for neighbor in tree[node]:
                if neighbor == parent:
                    continue
                current = dfs(neighbor, node)
                if current > max1:
                    max2 = max1
                    max1 = current
                elif current > max2:
                    max2 = current
            res = max(res, max1 + max2 + price[node])
            return max1 + price[node]

        dfs(0, -1)
        return res