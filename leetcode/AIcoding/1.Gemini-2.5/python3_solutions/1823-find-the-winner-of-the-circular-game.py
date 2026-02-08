class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        winner_pos = 0  # Represents the 0-indexed position of the winner
        for i in range(1, n + 1):
            winner_pos = (winner_pos + k) % i
        return winner_pos + 1  # Convert 0-indexed position to 1-indexed friend ID