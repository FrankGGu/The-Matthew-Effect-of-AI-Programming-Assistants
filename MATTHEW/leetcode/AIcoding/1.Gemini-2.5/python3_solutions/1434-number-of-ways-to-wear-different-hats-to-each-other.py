class Solution:
    def numberWays(self, hats: list[list[int]]) -> int:
        n = len(hats)
        MOD = 10**9 + 7

        hat_to_people_map = [[] for _ in range(41)]
        for person_idx, person_hats in enumerate(hats):
            for hat_id in person_hats:
                hat_to_people_map[hat_id].append(person_idx)

        dp = [0] * (1 << n)
        dp[0] = 1

        for hat_id in range(1, 41):
            if not hat_to_people_map[hat_id]:
                continue

            new_dp = list(dp) 

            for mask in range((1 << n) - 1, -1, -1):
                if dp[mask] == 0:
                    continue

                for person_idx in hat_to_people_map[hat_id]:
                    if not (mask & (1 << person_idx)):
                        new_mask = mask | (1 << person_idx)
                        new_dp[new_mask] = (new_dp[new_mask] + dp[mask]) % MOD

            dp = new_dp

        return dp[(1 << n) - 1]