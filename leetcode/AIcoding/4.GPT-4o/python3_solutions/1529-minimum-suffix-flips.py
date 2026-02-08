class Solution:
    def minFlips(self, target: str) -> int:
        flips = 0
        prev = '0'

        for ch in reversed(target):
            if ch != prev:
                flips += 1
                prev = ch

        return flips