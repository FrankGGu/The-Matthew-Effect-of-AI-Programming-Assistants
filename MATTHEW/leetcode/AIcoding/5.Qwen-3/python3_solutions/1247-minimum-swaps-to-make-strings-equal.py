class Solution:
    def minimumSwap(self, s1: str, s2: str) -> int:
        x, y = 0, 0
        for a, b in zip(s1, s2):
            if a == 'x' and b == 'y':
                x += 1
            elif a == 'y' and b == 'x':
                y += 1
        return x // 2 + y // 2 + (x % 2 + y % 2)