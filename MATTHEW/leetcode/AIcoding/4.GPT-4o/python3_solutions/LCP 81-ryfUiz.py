class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        return (self.find_winner(n, k) + 1) % n + 1

    def find_winner(self, n, k):
        if n == 1:
            return 0
        return (self.find_winner(n - 1, k) + k) % n