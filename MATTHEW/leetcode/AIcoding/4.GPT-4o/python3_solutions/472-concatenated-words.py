class Solution:
    def findAllConcatenatedWordsInADict(self, words: List[str]) -> List[str]:
        word_set = set(words)
        result = []

        def can_form(word):
            if word in word_set:
                return True
            for i in range(1, len(word)):
                prefix = word[:i]
                suffix = word[i:]
                if prefix in word_set and can_form(suffix):
                    return True
            return False

        for word in words:
            word_set.remove(word)
            if can_form(word):
                result.append(word)
            word_set.add(word)

        return result