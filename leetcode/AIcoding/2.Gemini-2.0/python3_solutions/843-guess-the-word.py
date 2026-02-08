import random

class Solution:
    def findSecretWord(self, wordlist: List[str], master: 'Master'):
        def match(word1, word2):
            matches = 0
            for i in range(6):
                if word1[i] == word2[i]:
                    matches += 1
            return matches

        possible_words = wordlist[:]
        for _ in range(10):
            guess = random.choice(possible_words)
            matches = master.guess(guess)
            if matches == 6:
                return
            possible_words = [word for word in possible_words if match(guess, word) == matches]