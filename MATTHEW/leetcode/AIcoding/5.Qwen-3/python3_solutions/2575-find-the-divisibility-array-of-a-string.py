class Solution:
    def divisibilityArray(self, word: str) -> List[int]:
        result = []
        current = 0
        for ch in word:
            current = (current * 10 + int(ch)) % len(word)
            result.append(1 if current == 0 else 0)
        return result