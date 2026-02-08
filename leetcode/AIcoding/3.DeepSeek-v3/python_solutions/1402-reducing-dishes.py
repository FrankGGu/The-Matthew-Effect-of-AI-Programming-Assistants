class Solution:
    def maxSatisfaction(self, satisfaction: List[int]) -> int:
        satisfaction.sort()
        n = len(satisfaction)
        total = 0
        res = 0

        for i in range(n - 1, -1, -1):
            if total + satisfaction[i] > 0:
                total += satisfaction[i]
                res += total
            else:
                break
        return res