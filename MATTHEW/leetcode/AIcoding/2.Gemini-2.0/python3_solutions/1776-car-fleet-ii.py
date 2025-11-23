class Solution:
    def getCollisionTimes(self, cars: List[List[int]]) -> List[float]:
        n = len(cars)
        ans = [-1.0] * n
        stack = []
        for i in range(n - 1, -1, -1):
            p, s = cars[i][0], cars[i][1]
            while stack and cars[stack[-1]][1] >= s:
                stack.pop()
            while stack:
                j = stack[-1]
                p2, s2 = cars[j][0], cars[j][1]
                if s >= s2:
                    stack.pop()
                    continue
                time = (p2 - p) / (s - s2)
                if ans[j] == -1.0 or time <= ans[j]:
                    ans[i] = time
                    break
                else:
                    stack.pop()
            stack.append(i)
        return ans