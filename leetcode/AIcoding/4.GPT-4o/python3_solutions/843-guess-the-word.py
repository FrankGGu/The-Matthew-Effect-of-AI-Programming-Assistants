class Master:
    def guess(self, word: str) -> int:
        pass

class Solution:
    def findSecretWord(self, wordlist: List[str], master: 'Master') -> None:
        import random

        def match(word1, word2):
            return sum(a == b for a, b in zip(word1, word2))

        for _ in range(10):
            guess = random.choice(wordlist)
            count = master.guess(guess)
            if count == 6:
                return
            wordlist = [word for word in wordlist if match(word, guess) == count]