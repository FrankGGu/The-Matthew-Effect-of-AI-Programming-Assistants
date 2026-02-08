class Solution:
    def productQueries(self, n: int, queries: list[list[int]]) -> list[int]:
        powers = []
        for i in range(32):
            if (n >> i) & 1:
                powers.append(1 << i)

        result = []
        for start, end in queries:
            product = 1
            for i in range(start, end + 1):
                product = (product * powers[i]) % (10**9 + 7)
            result.append(product)

        return result