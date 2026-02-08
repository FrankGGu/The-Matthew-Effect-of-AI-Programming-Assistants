class Solution:
    def divisibilityArray(self, word: str, m: int) -> list[int]:
        ans = []
        current_remainder = 0
        for char_digit in word:
            digit = int(char_digit)
            current_remainder = (current_remainder * 10 + digit) % m
            if current_remainder == 0:
                ans.append(1)
            else:
                ans.append(0)
        return ans