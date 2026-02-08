class Solution:
    def toGoatLatin(self, S: str) -> str:
        vowels = set('aeiouAEIOU')
        words = S.split()
        goat_latin = []

        for i, word in enumerate(words):
            if word[0] in vowels:
                goat_word = word + 'ma' + 'a' * (i + 1)
            else:
                goat_word = word[1:] + word[0] + 'ma' + 'a' * (i + 1)
            goat_latin.append(goat_word)

        return ' '.join(goat_latin)