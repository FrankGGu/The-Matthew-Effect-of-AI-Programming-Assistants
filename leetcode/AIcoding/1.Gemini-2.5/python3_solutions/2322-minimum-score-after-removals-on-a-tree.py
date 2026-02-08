import collections

class Solution:
    def minimumScore(self, nums: list[int], edges: list[list[int]]) -> int:
        n = len(nums)
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        subtree_xor = [0] * n
        tin = [0] * n
        tout = [0] * n
        timer = 0

        def dfs(u, p):
            nonlocal timer
            tin[u] = timer
            timer += 1

            current_xor_sum = nums[u]
            for v in adj[u]:
                if v == p:
                    continue
                current_xor_sum ^= dfs(v, u)

            subtree_xor[u] = current_xor_sum
            tout[u] = timer
            timer += 1
            return current_xor_sum

        dfs(0, -1)
        total_xor_tree = subtree_xor[0]

        def is_ancestor(u, v):
            return tin[u] <= tin[v] and tout[u] >= tout[v]

        min_score = float('inf')

        for i in range(1, n):
            for j in range(i + 1, n):
                xor_val1 = subtree_xor[i]
                xor_val2 = subtree_xor[j]

                c1, c2, c3 = 0, 0, 0

                if is_ancestor(i, j):
                    c1 = xor_val2
                    c2 = xor_val1 ^ xor_val2
                    c3 = total_xor_tree ^ xor_val1
                elif is_ancestor(j, i):
                    c1 = xor_val1
                    c2 = xor_val2 ^ xor_val1
                    c3 = total_xor_tree ^ xor_val2
                else:
                    c1 = xor_val1
                    c2 = xor_val2
                    c3 = total_xor_tree ^ xor_val1 ^ xor_val2

                current_max = max(c1, c2, c3)
                current_min = min(c1, c2, c3)
                min_score = min(min_score, current_max - current_min)

        return min_score