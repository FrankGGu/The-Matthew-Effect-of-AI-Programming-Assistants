class Solution:
    def iceBreakingGame(self, num: int, target: int) -> int:
        res = 0
        for i in range(2, num + 1):
            res = (res + target) % i
        return res