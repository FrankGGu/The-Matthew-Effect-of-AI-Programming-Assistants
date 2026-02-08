class Solution:
    def minFlips(self, target: str) -> int:
        flips = 0
        current = '0'
        for c in target:
            if c != current:
                flips += 1
                current = '1' if current == '0' else '0'
        return flips