class Solution:
    def countStrings(self, words: List[str], s: str) -> int:
        from collections import Counter

        s_count = Counter(s)
        result = 0

        for word in words:
            word_count = Counter(word)
            if all(word_count[char] >= s_count[char] for char in s_count):
                result += 1

        return result