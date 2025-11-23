class Solution:
    def maxSatisfaction(self, satisfaction: List[int]) -> int:
        satisfaction.sort()
        n = len(satisfaction)
        total = 0
        res = 0
        for i in range(n - 1, -1, -1):
            total += satisfaction[i]
            if total > 0:
                res += total
            else:
                break
        return res