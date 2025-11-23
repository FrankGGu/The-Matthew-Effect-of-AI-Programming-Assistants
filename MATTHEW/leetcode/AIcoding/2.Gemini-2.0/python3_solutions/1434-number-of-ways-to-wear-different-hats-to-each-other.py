from functools import lru_cache

class Solution:
    def numberWays(self, hats: List[List[int]]) -> int:
        n = len(hats)
        hat_to_people = [[] for _ in range(41)]
        for i in range(n):
            for hat in hats[i]:
                hat_to_people[hat].append(i)

        @lru_cache(None)
        def solve(hat_id, mask):
            if mask == (1 << n) - 1:
                return 1
            if hat_id > 40:
                return 0

            ans = solve(hat_id + 1, mask)
            for person in hat_to_people[hat_id]:
                if not (mask & (1 << person)):
                    ans = (ans + solve(hat_id + 1, mask | (1 << person))) % (10**9 + 7)
            return ans

        return solve(1, 0)