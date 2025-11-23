class Solution:
    def divisibilityArray(self, word: str, m: int) -> list[int]:
        n = len(word)
        divisibility = [0] * n
        remainder = 0
        for i in range(n):
            remainder = (remainder * 10 + int(word[i])) % m
            if remainder == 0:
                divisibility[i] = 1
        return divisibility