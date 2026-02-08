from collections import Counter

class Solution:
    def customSortString(self, order: str, s: str) -> str:
        char_counts = Counter(s)
        result_chars = []

        for char_in_order in order:
            if char_in_order in char_counts:
                result_chars.append(char_in_order * char_counts[char_in_order])
                del char_counts[char_in_order]

        for char_remaining, count in char_counts.items():
            result_chars.append(char_remaining * count)

        return "".join(result_chars)