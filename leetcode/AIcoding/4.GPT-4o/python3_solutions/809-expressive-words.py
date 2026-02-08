class Solution:
    def expressiveWords(self, s: str, words: List[str]) -> int:
        def is_stretchy(s, word):
            if len(s) < len(word):
                return False
            i, j = 0, 0
            while i < len(s) and j < len(word):
                if s[i] == word[j]:
                    count_s, count_w = 0, 0
                    while i < len(s) and s[i] == s[i - count_s]: 
                        count_s += 1
                        i += 1
                    while j < len(word) and word[j] == word[j - count_w]: 
                        count_w += 1
                        j += 1
                    if count_s < count_w or (count_s < 3 and count_s != count_w):
                        return False
                else:
                    return False
            return i == len(s) and j == len(word)

        return sum(is_stretchy(s, word) for word in words)