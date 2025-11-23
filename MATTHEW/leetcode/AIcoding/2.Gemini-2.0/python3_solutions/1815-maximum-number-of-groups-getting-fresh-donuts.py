from collections import Counter
from functools import lru_cache

class Solution:
    def maxHappyGroups(self, batchSize: int, groups: list[int]) -> int:
        counts = Counter(g % batchSize for g in groups)
        happy = counts[0]
        del counts[0]

        @lru_cache(None)
        def dp(state):
            if sum(state) == 0:
                return 0

            arr = list(state)
            ans = 0
            curr_rem = 0
            for i in range(1, batchSize):
                curr_rem += i * arr[i]
            curr_rem %= batchSize

            for i in range(1, batchSize):
                if arr[i] > 0:
                    new_state = list(state)
                    new_state[i] -= 1
                    new_state = tuple(new_state)
                    new_happy = 1 if curr_rem == i else 0
                    ans = max(ans, dp(new_state) + new_happy)

            return ans

        state = tuple(counts[i] for i in range(1, batchSize))
        return happy + dp(state)