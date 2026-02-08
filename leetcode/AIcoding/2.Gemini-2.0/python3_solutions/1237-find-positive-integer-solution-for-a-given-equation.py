class Solution:
    def findSolution(self, customfunction: 'CustomFunction', z: int) -> List[List[int]]:
        res = []
        for x in range(1, 1001):
            l, r = 1, 1001
            while l <= r:
                mid = (l + r) // 2
                val = customfunction.f(x, mid)
                if val == z:
                    res.append([x, mid])
                    break
                elif val < z:
                    l = mid + 1
                else:
                    r = mid - 1
        return res