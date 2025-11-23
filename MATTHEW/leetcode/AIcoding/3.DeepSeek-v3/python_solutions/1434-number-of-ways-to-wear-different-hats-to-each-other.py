class Solution:
    def numberWays(self, hats: List[List[int]]) -> int:
        MOD = 10**9 + 7
        n = len(hats)
        hat_to_people = defaultdict(list)
        max_hat = 0
        for person, person_hats in enumerate(hats):
            for h in person_hats:
                hat_to_people[h].append(person)
                max_hat = max(max_hat, h)

        dp = [0] * (1 << n)
        dp[0] = 1

        for h in range(1, max_hat + 1):
            new_dp = dp.copy()
            for person in hat_to_people[h]:
                for mask in range(1 << n):
                    if mask & (1 << person):
                        continue
                    new_mask = mask | (1 << person)
                    new_dp[new_mask] = (new_dp[new_mask] + dp[mask]) % MOD
            dp = new_dp

        return dp[(1 << n) - 1] % MOD