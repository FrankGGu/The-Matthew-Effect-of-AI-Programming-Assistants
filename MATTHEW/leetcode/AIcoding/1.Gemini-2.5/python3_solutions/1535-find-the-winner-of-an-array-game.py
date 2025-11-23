class Solution:
    def getWinner(self, arr: list[int], k: int) -> int:
        current_winner = arr[0]
        consecutive_wins = 0

        for i in range(1, len(arr)):
            opponent = arr[i]
            if current_winner > opponent:
                consecutive_wins += 1
            else:
                current_winner = opponent
                consecutive_wins = 1

            if consecutive_wins == k:
                return current_winner

        return current_winner