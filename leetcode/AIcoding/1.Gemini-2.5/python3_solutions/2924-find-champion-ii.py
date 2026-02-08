class Solution:
    def findChampion(self, n: int, matches: list[list[int]]) -> int:
        losers = set()

        for winner, loser in matches:
            losers.add(loser)

        champion = -1
        for i in range(n):
            if i not in losers:
                champion = i
                break

        return champion