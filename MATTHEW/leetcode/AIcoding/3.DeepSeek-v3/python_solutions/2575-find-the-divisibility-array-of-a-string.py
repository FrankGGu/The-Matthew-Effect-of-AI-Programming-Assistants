class Solution:
    def divisibilityArray(self, word: str, m: int) -> List[int]:
        n = len(word)
        res = []
        remainder = 0
        for ch in word:
            digit = int(ch)
            remainder = (remainder * 10 + digit) % m
            res.append(1 if remainder == 0 else 0)
        return res