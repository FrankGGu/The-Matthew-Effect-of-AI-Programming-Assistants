class Solution:
    def digitGame(self, n: int) -> bool:
        if n == 1:
            return False
        return n % 2 == 0