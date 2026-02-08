class Solution:
    def reverseOnlyLetters(self, s: str) -> str:
        letters = [c for c in s if c.isalpha()]
        letters.reverse()
        result = ""
        letter_index = 0
        for c in s:
            if c.isalpha():
                result += letters[letter_index]
                letter_index += 1
            else:
                result += c
        return result