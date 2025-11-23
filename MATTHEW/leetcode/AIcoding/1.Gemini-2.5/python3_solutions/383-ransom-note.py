from collections import Counter

class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        magazine_counts = Counter(magazine)

        for char in ransomNote:
            if magazine_counts[char] > 0:
                magazine_counts[char] -= 1
            else:
                return False

        return True