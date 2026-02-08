class Solution:
    def maxValue(self, n: str, x: str) -> str:
        if n[0] == '-' and x > '0':
            return n + x
        elif n[0] == '-':
            for i in range(1, len(n)):
                if n[i] > x:
                    return n[:i] + x + n[i:]
            return n + x
        else:
            for i in range(len(n)):
                if n[i] < x:
                    return n[:i] + x + n[i:]
            return n + x