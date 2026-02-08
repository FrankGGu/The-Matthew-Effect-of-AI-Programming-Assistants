class Solution:
    def findChampion(self, matches: List[List[int]]) -> int:
        wins = {}
        losses = {}

        for winner, loser in matches:
            wins[winner] = wins.get(winner, 0) + 1
            losses[loser] = losses.get(loser, 0) + 1

        for player in wins:
            if wins[player] == len(matches) and player not in losses:
                return player

        return -1