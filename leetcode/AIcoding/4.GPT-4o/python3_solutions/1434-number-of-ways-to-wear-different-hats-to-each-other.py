class Solution:
    def numberOfWays(self, hats: List[List[int]]) -> int:
        MOD = 10**9 + 7
        n = len(hats)
        hat_to_people = defaultdict(list)

        for person in range(n):
            for hat in hats[person]:
                hat_to_people[hat].append(person)

        dp = [0] * (1 << n)
        dp[0] = 1

        for hat in range(1, 41):
            if hat in hat_to_people:
                new_dp = dp[:]
                for person in hat_to_people[hat]:
                    for mask in range((1 << n) - 1, -1, -1):
                        if dp[mask] > 0 and not (mask & (1 << person)):
                            new_dp[mask | (1 << person)] = (new_dp[mask | (1 << person)] + dp[mask]) % MOD
                dp = new_dp

        return dp[(1 << n) - 1]