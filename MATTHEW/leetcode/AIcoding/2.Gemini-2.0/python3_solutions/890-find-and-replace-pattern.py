def findAndReplacePattern(words, pattern):
    def match(word, pattern):
        mapping = {}
        mapped = set()
        for i in range(len(word)):
            char_word = word[i]
            char_pattern = pattern[i]
            if char_pattern not in mapping:
                if char_word in mapped:
                    return False
                mapping[char_pattern] = char_word
                mapped.add(char_word)
            elif mapping[char_pattern] != char_word:
                return False
        return True

    result = []
    for word in words:
        if match(word, pattern):
            result.append(word)
    return result