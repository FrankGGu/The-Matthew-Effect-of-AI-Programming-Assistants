class Solution:
    def antPos(self, n: int, time: int) -> int:
        if time % (2 * n) < n:
            return time % (2 * n)
        else:
            return 2 * n - (time % (2 * n))