class Solution:
    def countConsistentStrings(self, allowed: str, words: list[str]) -> int:
        allowed_set = set(allowed)
        count = 0
        for word in words:
            consistent = True
            for char in word:
                if char not in allowed_set:
                    consistent = False
                    break
            if consistent:
                count += 1
        return count