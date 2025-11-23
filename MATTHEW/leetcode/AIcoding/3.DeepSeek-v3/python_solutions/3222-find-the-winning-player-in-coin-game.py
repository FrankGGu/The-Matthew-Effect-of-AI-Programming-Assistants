class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        players = list(range(1, n + 1))
        current = 0
        while len(players) > 1:
            current = (current + k - 1) % len(players)
            players.pop(current)
        return players[0]