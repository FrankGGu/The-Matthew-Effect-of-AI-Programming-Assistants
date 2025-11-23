class Solution:
    def countValidWords(self, sentence: str) -> int:
        words = sentence.split()
        count = 0

        for word in words:
            if all(c.isalpha() or c in '- ' for c in word) and word.count('-') <= 1:
                if '-' in word:
                    parts = word.split('-')
                    if any(part == '' for part in parts) or len(parts) > 2 or any(not part.isalpha() for part in parts):
                        continue
                count += 1

        return count