class Solution:
    def countValidWords(self, sentence: str) -> int:
        def is_valid(word):
            if not word:
                return False
            for i in range(len(word)):
                if word[i].isdigit():
                    return False
                if word[i] == '-':
                    if i == 0 or i == len(word) - 1:
                        return False
                    if not (word[i-1].islower() and word[i+1].islower()):
                        return False
            return True

        count = 0
        for word in sentence.split():
            if is_valid(word):
                count += 1
        return count