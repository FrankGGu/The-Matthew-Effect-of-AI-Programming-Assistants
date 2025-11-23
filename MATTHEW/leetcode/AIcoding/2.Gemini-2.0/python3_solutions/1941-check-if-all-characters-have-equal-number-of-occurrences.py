class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        first_count = list(counts.values())[0]
        for count in counts.values():
            if count != first_count:
                return False

        return True