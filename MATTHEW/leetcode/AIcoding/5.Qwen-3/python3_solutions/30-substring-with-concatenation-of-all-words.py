from collections import defaultdict

class Solution:
    def findSubstring(self, s: str, words: list[str]) -> list[int]:
        if not s or not words:
            return []

        word_len = len(words[0])
        total_words = len(words)
        total_len = word_len * total_words
        word_count = defaultdict(int)
        for word in words:
            word_count[word] += 1

        result = []

        for i in range(len(s) - total_len + 1):
            seen = defaultdict(int)
            match = True
            for j in range(total_words):
                start = i + j * word_len
                word = s[start:start + word_len]
                if word_count[word] == 0:
                    match = False
                    break
                seen[word] += 1
                if seen[word] > word_count[word]:
                    match = False
                    break
            if match:
                result.append(i)

        return result