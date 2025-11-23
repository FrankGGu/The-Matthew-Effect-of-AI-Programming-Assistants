import re

class Solution:
    def countValidWords(self, sentence: str) -> int:
        count = 0
        for word in sentence.split():
            if re.match(r"^([a-z]+(-?[a-z]+)?|[.!?,]?)$", word):
                if word:
                    valid = True
                    hyphen_count = word.count('-')
                    if hyphen_count > 1:
                        valid = False
                    elif hyphen_count == 1:
                        hyphen_index = word.index('-')
                        if hyphen_index == 0 or hyphen_index == len(word) - 1 or not word[hyphen_index - 1].isalpha() or not word[hyphen_index + 1].isalpha():
                            valid = False
                    if valid:
                        count += 1
        return count