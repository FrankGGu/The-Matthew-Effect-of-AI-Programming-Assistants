class Solution:
    def countValidWords(self, sentence: str) -> int:
        import re
        words = sentence.split()
        valid_word_count = 0
        for word in words:
            if re.match(r'^[a-z]+(-[a-z]+)?$', word) or re.match(r'^[a-z]+(-[a-z]+)?[!.,]$', word) or re.match(r'^[a-z]+(-[a-z]+)?[!.,]$', word):
                valid_word_count += 1
        return valid_word_count