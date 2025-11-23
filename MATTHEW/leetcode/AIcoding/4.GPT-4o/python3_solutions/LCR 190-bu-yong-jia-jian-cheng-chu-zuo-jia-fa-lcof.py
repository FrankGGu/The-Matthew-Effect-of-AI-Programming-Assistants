class Solution:
    def encrypt(self, text: str, n: int) -> str:
        if n <= 0:
            return text

        for _ in range(n):
            odd = text[1::2]
            even = text[0::2]
            text = odd + even

        return text