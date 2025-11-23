class Solution:
    def countValidWords(self, sentence: str) -> int:
        def is_valid(word):
            hyphen_count = 0
            for i, c in enumerate(word):
                if c.isdigit():
                    return False
                if c == '-':
                    if hyphen_count >= 1:
                        return False
                    if i == 0 or i == len(word) - 1:
                        return False
                    if not word[i-1].islower() or not word[i+1].islower():
                        return False
                    hyphen_count += 1
                if c in ('!', '.', ',') and i != len(word) - 1:
                    return False
            return True

        words = sentence.split()
        count = 0
        for word in words:
            if is_valid(word):
                count += 1
        return count