class Solution:
    def atMostNGivenDigitSet(self, D: List[str], N: str) -> int:
        n = len(N)
        m = len(D)
        count = 0

        for i in range(1, n):
            count += m ** i

        for i in range(n):
            if N[i] not in D:
                break
            if i == n - 1:
                count += 1
                break
            count += sum(d < N[i] for d in D) * (m ** (n - i - 1))

        return count