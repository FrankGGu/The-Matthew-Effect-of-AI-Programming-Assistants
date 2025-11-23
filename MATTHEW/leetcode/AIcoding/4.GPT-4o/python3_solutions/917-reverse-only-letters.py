class Solution:
    def reverseOnlyLetters(self, s: str) -> str:
        letters = [c for c in s if c.isalpha()]
        result = []
        j = len(letters) - 1

        for c in s:
            if c.isalpha():
                result.append(letters[j])
                j -= 1
            else:
                result.append(c)

        return ''.join(result)