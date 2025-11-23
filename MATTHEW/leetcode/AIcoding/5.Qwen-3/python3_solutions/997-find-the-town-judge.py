class Solution:
    def findJudge(self, n: int, trust: List[List[int]]) -> int:
        judge = -1
        count = [0] * (n + 1)
        for a, b in trust:
            count[a] -= 1
            count[b] += 1
        for i in range(1, n + 1):
            if count[i] == n - 1:
                judge = i
                break
        return judge