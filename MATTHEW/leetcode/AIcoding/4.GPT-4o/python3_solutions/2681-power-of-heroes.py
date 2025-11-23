class Solution:
    def powerOfHeroes(self, heroes: List[int], k: int) -> int:
        n = len(heroes)
        dp = [0] * (k + 1)
        dp[0] = 1

        for hero in heroes:
            for j in range(k, hero - 1, -1):
                dp[j] = (dp[j] + dp[j - hero]) % (10**9 + 7)

        return dp[k]