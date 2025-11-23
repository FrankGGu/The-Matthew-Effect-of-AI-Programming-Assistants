class Solution:
    def smallestGoodBase(self, n: str) -> str:
        n = int(n)
        m = n.bit_length()
        for i in range(m, 1, -1):
            k = int(n ** (1 / i))
            if k <= 1:
                continue
            sum_k = 0
            for j in range(i + 1):
                sum_k = sum_k * k + 1
            if sum_k == n:
                return str(k)
        return str(n - 1)