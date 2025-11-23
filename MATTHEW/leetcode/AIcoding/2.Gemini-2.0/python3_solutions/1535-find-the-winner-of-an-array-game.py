class Solution:
    def getWinner(self, arr: list[int], k: int) -> int:
        if k >= len(arr) - 1:
            return max(arr)

        winner = arr[0]
        wins = 0

        for i in range(1, len(arr)):
            opponent = arr[i]
            if winner > opponent:
                wins += 1
            else:
                winner = opponent
                wins = 1

            if wins == k:
                return winner

        return winner