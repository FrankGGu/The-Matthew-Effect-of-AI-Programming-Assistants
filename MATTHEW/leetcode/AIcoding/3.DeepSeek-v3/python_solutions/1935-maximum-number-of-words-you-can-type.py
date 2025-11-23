class Solution:
    def canBeTypedWords(self, text: str, brokenLetters: str) -> int:
        broken = set(brokenLetters)
        words = text.split()
        count = 0
        for word in words:
            can_type = True
            for c in word:
                if c in broken:
                    can_type = False
                    break
            if can_type:
                count += 1
        return count