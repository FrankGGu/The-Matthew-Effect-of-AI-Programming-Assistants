from collections import Counter

class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not s or not words:
            return []

        word_len = len(words[0])
        word_count = len(words)
        total_len = word_len * word_count
        words_counter = Counter(words)
        result = []

        for i in range(len(s) - total_len + 1):
            substring = s[i:i + total_len]
            substring_counter = Counter([substring[j:j + word_len] for j in range(0, total_len, word_len)])
            if substring_counter == words_counter:
                result.append(i)

        return result