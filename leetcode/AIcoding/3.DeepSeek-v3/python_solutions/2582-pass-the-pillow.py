class Solution:
    def passThePillow(self, n: int, time: int) -> int:
        cycle = 2 * (n - 1)
        time %= cycle
        if time < n:
            return time + 1
        else:
            return 2 * n - time - 1