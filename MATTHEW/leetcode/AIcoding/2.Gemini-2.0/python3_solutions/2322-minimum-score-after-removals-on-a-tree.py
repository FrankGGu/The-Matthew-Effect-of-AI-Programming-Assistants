class Solution:
    def minimumScore(self, nums: list[int], edges: list[list[int]]) -> int:
        n = len(nums)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        subtree_xor = [0] * n
        parent = [-1] * n

        def dfs(node, par):
            parent[node] = par
            subtree_xor[node] = nums[node]
            for neighbor in adj[node]:
                if neighbor != par:
                    dfs(neighbor, node)
                    subtree_xor[node] ^= subtree_xor[neighbor]

        dfs(0, -1)

        total_xor = subtree_xor[0]

        ans = float('inf')

        for i in range(1, n):
            for j in range(i + 1, n):
                u, v = i, j
                a, b, c = 0, 0, 0

                ancestor_u = False
                curr = v
                while curr != -1:
                    if curr == u:
                        ancestor_u = True
                        break
                    curr = parent[curr]

                if ancestor_u:
                    a = subtree_xor[u]
                    b = subtree_xor[v]
                    c = total_xor ^ a ^ b
                else:
                    ancestor_v = False
                    curr = u
                    while curr != -1:
                        if curr == v:
                            ancestor_v = True
                            break
                        curr = parent[curr]

                    if ancestor_v:
                        a = subtree_xor[v]
                        b = subtree_xor[u]
                        c = total_xor ^ a ^ b
                    else:
                        a = subtree_xor[u]
                        b = subtree_xor[v]
                        c = total_xor ^ a ^ b

                ans = min(ans, max(a, b, c) - min(a, b, c))

        return ans