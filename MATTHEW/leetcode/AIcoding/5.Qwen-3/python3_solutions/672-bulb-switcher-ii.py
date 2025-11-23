class Solution:
    def bulbSwitcherII(self, n: int, m: int) -> int:
        return (1 << m) - 1 if n >= m else (1 << n) - 1