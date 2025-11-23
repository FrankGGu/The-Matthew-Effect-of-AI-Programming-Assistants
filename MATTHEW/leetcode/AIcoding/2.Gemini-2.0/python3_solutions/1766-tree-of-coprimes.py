from collections import defaultdict

def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)

def getCoprimes(nums, edges):
    n = len(nums)
    adj = defaultdict(list)
    for u, v in edges:
        adj[u].append(v)
        adj[v].append(u)

    ans = [-1] * n

    def dfs(node, parent, path):
        nonlocal ans

        best_ancestor = -1
        best_depth = -1

        for depth, (ancestor, val) in enumerate(reversed(path)):
            if gcd(nums[node], val) == 1:
                if depth > best_depth:
                    best_depth = depth
                    best_ancestor = ancestor

        ans[node] = best_ancestor

        new_path = path + [(node, nums[node])]

        for neighbor in adj[node]:
            if neighbor != parent:
                dfs(neighbor, node, new_path)

    dfs(0, -1, [])
    return ans