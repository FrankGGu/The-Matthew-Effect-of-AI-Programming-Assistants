class Solution:
    def decrementalString(self, n: int) -> str:
        return ''.join(chr(97 + i) for i in range(n))[::-1]