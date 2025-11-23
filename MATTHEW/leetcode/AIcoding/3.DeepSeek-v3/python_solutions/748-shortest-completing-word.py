from collections import defaultdict

class Solution:
    def shortestCompletingWord(self, licensePlate: str, words: List[str]) -> str:
        def count_letters(s):
            count = defaultdict(int)
            for c in s.lower():
                if c.isalpha():
                    count[c] += 1
            return count

        target = count_letters(licensePlate)
        min_len = float('inf')
        result = ""

        for word in words:
            word_count = count_letters(word)
            match = True
            for c in target:
                if word_count[c] < target[c]:
                    match = False
                    break
            if match:
                if len(word) < min_len:
                    min_len = len(word)
                    result = word
        return result