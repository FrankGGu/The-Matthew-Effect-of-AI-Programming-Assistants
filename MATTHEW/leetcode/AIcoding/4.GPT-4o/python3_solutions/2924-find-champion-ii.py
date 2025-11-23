class Solution:
    def findChampion(self, players: List[int], matches: List[List[int]]) -> int:
        from collections import defaultdict

        wins = defaultdict(int)
        losses = defaultdict(int)

        for winner, loser in matches:
            wins[winner] += 1
            losses[loser] += 1

        champion = -1
        for player in players:
            if wins[player] == len(players) - 1 and player not in losses:
                champion = player
                break

        return champion