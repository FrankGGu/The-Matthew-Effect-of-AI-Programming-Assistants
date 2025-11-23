class Solution:
    def reverseDegree(self, s: str, k: int) -> str:
        n = len(s)
        if k > n // 2:
            k = n // 2

        res = list(s)

        for i in range(k):
            res[i], res[n - 1 - i] = res[n - 1 - i], res[i]

        return "".join(res)