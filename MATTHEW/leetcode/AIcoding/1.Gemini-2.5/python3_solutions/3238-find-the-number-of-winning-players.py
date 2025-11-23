class Solution:
    def winningPlayers(self, players: list[int]) -> int:
        if not players:
            return 0

        max_strength = max(players)

        count_max_strength = players.count(max_strength)

        if count_max_strength == 1:
            return 1
        else:
            return 0