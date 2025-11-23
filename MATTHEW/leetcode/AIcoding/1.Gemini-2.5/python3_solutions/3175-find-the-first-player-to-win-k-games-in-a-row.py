import collections

class Solution:
    def getWinner(self, arr: list[int], k: int) -> int:
        n = len(arr)

        if k >= n - 1:
            return max(arr)

        dq = collections.deque(arr)

        current_winner = dq.popleft()
        consecutive_wins = 0

        while True:
            opponent = dq.popleft()

            if current_winner > opponent:
                consecutive_wins += 1
                dq.append(opponent)
            else:
                dq.append(current_winner)
                current_winner = opponent
                consecutive_wins = 1

            if consecutive_wins == k:
                return current_winner