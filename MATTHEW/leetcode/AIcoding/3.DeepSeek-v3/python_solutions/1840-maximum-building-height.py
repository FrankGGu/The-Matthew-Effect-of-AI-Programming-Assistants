class Solution:
    def maxBuilding(self, n: int, restrictions: List[List[int]]) -> int:
        restrictions.append([1, 0])
        restrictions.sort()
        if restrictions[-1][0] != n:
            restrictions.append([n, n - 1])

        m = len(restrictions)
        for i in range(1, m):
            restrictions[i][1] = min(restrictions[i][1], restrictions[i-1][1] + restrictions[i][0] - restrictions[i-1][0])

        for i in range(m-2, -1, -1):
            restrictions[i][1] = min(restrictions[i][1], restrictions[i+1][1] + restrictions[i+1][0] - restrictions[i][0])

        res = 0
        for i in range(1, m):
            l, h1 = restrictions[i-1]
            r, h2 = restrictions[i]
            res = max(res, max(h1, h2) + (r - l - abs(h1 - h2)) // 2)

        return res