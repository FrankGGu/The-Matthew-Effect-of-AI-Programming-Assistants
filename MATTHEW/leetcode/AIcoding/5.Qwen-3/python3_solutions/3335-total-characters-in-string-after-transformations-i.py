class Solution:
    def numberOfSpecialChars(self, word: str) -> int:
        seen = set()
        count = 0
        for c in word:
            if c.islower() and c.upper() not in seen:
                seen.add(c)
            elif c.isupper() and c.lower() not in seen:
                seen.add(c)
            else:
                if c.islower() and c.upper() in seen:
                    count += 1
                elif c.isupper() and c.lower() in seen:
                    count += 1
        return count