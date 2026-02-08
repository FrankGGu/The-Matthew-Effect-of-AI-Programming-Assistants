class Solution:
    def get_value(self, word, mapping):
        value = 0
        for char in word:
            value = value * 10 + mapping[char]
        return value

    def is_valid(self, firstWord, secondWord, result, mapping):
        if len(firstWord) > 1 and mapping[firstWord[0]] == 0:
            return False
        if len(secondWord) > 1 and mapping[secondWord[0]] == 0:
            return False
        if len(result) > 1 and mapping[result[0]] == 0:
            return False
        return True

    def isSolvable(self, words, result):
        chars = set()
        for word in words:
            for char in word:
                chars.add(char)
        for char in result:
            chars.add(char)

        chars = list(chars)
        n = len(chars)
        mapping = {}

        def backtrack(index):
            if index == n:
                mapping_copy = mapping.copy()
                firstWord = words[0]
                secondWord = words[1] if len(words) > 1 else ""

                val1 = self.get_value(firstWord, mapping_copy)
                val2 = self.get_value(secondWord, mapping_copy) if len(words) > 1 else 0
                val3 = self.get_value(result, mapping_copy)

                if self.is_valid(words[0], words[1] if len(words) > 1 else "", result, mapping_copy):
                    return val1 + val2 == val3
                else:
                    return False

            for digit in range(10):
                if digit not in mapping.values():
                    mapping[chars[index]] = digit
                    if backtrack(index + 1):
                        return True
                    del mapping[chars[index]]
            return False

        return backtrack(0)