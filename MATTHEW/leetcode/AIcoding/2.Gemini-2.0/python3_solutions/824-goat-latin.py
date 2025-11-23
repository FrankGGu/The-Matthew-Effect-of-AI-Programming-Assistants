class Solution:
    def toGoatLatin(self, sentence: str) -> str:
        words = sentence.split()
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        result = []
        for i, word in enumerate(words):
            if word[0] in vowels:
                new_word = word + 'ma' + 'a' * (i + 1)
            else:
                new_word = word[1:] + word[0] + 'ma' + 'a' * (i + 1)
            result.append(new_word)
        return ' '.join(result)