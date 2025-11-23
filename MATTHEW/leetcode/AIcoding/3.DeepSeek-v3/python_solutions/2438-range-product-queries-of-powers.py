class Solution:
    def productQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        MOD = 10**9 + 7
        powers = []
        current = 1
        while current <= n:
            if current & n:
                powers.append(current)
            current <<= 1

        prefix = [1]
        for num in powers:
            prefix.append(prefix[-1] * num)

        res = []
        for l, r in queries:
            res.append((prefix[r + 1] // prefix[l]) % MOD)
        return res