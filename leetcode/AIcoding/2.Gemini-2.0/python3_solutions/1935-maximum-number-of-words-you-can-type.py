class Solution:
    def canBeTypedWords(self, text: str, brokenLetters: str) -> int:
        words = text.split()
        count = 0
        for word in words:
            broken = False
            for char in brokenLetters:
                if char in word:
                    broken = True
                    break
            if not broken:
                count += 1
        return count