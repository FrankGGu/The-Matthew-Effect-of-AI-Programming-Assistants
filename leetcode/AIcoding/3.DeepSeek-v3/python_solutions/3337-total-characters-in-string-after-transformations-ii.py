class Solution:
    def totalCharacters(self, s: str, transformations: List[List[str]]) -> int:
        from collections import defaultdict

        char_counts = defaultdict(int)
        for c in s:
            char_counts[c] += 1

        for old, new in transformations:
            count = char_counts[old]
            char_counts[new] += count
            char_counts[old] = 0

        return sum(char_counts.values())