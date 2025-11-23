from collections import defaultdict

class Solution:
    def countPalindromePaths(self, parent: list[int], s: str) -> int:
        n = len(parent)
        adj = defaultdict(list)
        for i in range(1, n):
            adj[parent[i]].append(i)

        ans = 0
        cnt = defaultdict(int)
        cnt[0] = 1

        def dfs(node, mask):
            nonlocal ans
            mask ^= (1 << (ord(s[node]) - ord('a')))

            for i in range(26):
                ans += cnt[mask ^ (1 << i)]
            ans += cnt[mask]

            cnt[mask] += 1

            for neighbor in adj[node]:
                dfs(neighbor, mask)

            cnt[mask] -= 1

        dfs(0, 0)
        return ans