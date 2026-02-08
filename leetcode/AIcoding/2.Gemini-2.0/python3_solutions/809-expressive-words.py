def expressiveWords(s: str, words: list[str]) -> int:
    def is_stretchy(s, word):
        i, j = 0, 0
        while i < len(s) and j < len(word):
            if s[i] != word[j]:
                return False
            s_count = 0
            s_char = s[i]
            while i < len(s) and s[i] == s_char:
                s_count += 1
                i += 1

            word_count = 0
            word_char = word[j]
            while j < len(word) and word[j] == word_char:
                word_count += 1
                j += 1

            if s_count < word_count:
                return False
            if s_count != word_count and s_count < 3:
                return False

        return i == len(s) and j == len(word)

    count = 0
    for word in words:
        if is_stretchy(s, word):
            count += 1
    return count