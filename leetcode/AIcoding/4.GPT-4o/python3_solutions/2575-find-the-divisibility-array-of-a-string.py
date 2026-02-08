class Solution:
    def divisibilityArray(self, word: str, m: int) -> List[int]:
        n = len(word)
        result = []
        current_number = 0

        for i in range(n):
            current_number = (current_number * 10 + int(word[i])) % m
            if current_number == 0:
                result.append(1)
            else:
                result.append(0)

        return result