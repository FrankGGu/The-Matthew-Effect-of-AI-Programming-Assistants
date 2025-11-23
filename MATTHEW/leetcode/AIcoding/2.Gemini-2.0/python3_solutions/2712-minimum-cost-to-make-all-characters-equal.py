class Solution:
    def minCost(self, s: str, cost: list[int]) -> int:
        n = len(s)
        ans = 0
        i = 0
        while i < n - 1:
            j = i
            mx = 0
            sm = 0
            while j < n and s[i] == s[j]:
                mx = max(mx, cost[j])
                sm += cost[j]
                j += 1
            ans += sm - mx
            i = j
        return ans