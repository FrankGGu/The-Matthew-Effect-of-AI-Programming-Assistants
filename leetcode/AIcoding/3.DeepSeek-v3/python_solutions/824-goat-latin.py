class Solution:
    def toGoatLatin(self, S: str) -> str:
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        words = S.split()
        for i in range(len(words)):
            word = words[i]
            if word[0] in vowels:
                new_word = word + 'ma'
            else:
                new_word = word[1:] + word[0] + 'ma'
            new_word += 'a' * (i + 1)
            words[i] = new_word
        return ' '.join(words)