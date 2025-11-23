from functools import lru_cache

class Solution:
    def earliestAndLatest(self, n: int, firstPlayer: int, secondPlayer: int) -> list[int]:
        firstPlayer -= 1
        secondPlayer -= 1

        @lru_cache(None)
        def solve(players, first, second, round_num):
            if len(players) == 1:
                return round_num, round_num

            if first > second:
                first, second = second, first

            if second == first + 1 and len(players) == 2:
                return round_num, round_num

            min_round = float('inf')
            max_round = float('-inf')

            for new_first in range((first + 1) // 2, first // 2 + 1):
                for new_second in range((second + 1) // 2, second // 2 + 1):

                    new_players = (len(players) + 1) // 2

                    if new_first == new_second and new_first != (new_players -1 if new_players > 1 else 0):
                        continue

                    earliest, latest = solve(list(range(new_players)), new_first, new_second, round_num + 1)
                    min_round = min(min_round, earliest)
                    max_round = max(max_round, latest)

            return min_round, max_round

        return solve(list(range(n)), firstPlayer, secondPlayer, 1)