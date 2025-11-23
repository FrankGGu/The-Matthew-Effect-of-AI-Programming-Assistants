import random

class Solution:
    def findSecretWord(self, wordlist: List[str], master: 'Master') -> None:
        def match(a, b):
            return sum(i == j for i, j in zip(a, b))

        n = 0
        while n < 6:
            guess = random.choice(wordlist)
            n = master.guess(guess)
            wordlist = [w for w in wordlist if match(guess, w) == n]