class Solution:
    def numberWays(self, hats: List[List[int]]) -> int:
        from collections import defaultdict

        hat_to_people = defaultdict(list)
        for person, hat_list in enumerate(hats):
            for hat in hat_list:
                hat_to_people[hat].append(person)

        n = len(hats)
        dp = [0] * (1 << n)
        dp[0] = 1

        for hat in hat_to_people:
            people = hat_to_people[hat]
            for mask in range(1 << n):
                if dp[mask] == 0:
                    continue
                for p in people:
                    if not (mask & (1 << p)):
                        dp[mask | (1 << p)] += dp[mask]

        return dp[(1 << n) - 1]