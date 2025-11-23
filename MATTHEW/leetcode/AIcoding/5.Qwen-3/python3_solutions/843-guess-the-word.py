from typing import List
import random

class Master:
    def guessWord(self, wordlist: List[str], master: 'Master') -> None:
        pass

    def guess(self, word: str) -> int:
        pass

class Solution:
    def findSecretWord(self, wordlist: List[str], master: Master) -> None:
        n = 0
        while n < 10:
            i = random.randint(0, len(wordlist) - 1)
            match = master.guess(wordlist[i])
            if match == 0:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 0]
            elif match == 1:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 1]
            elif match == 2:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 2]
            elif match == 3:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 3]
            elif match == 4:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 4]
            elif match == 5:
                wordlist = [w for w in wordlist if self.getMatches(w, wordlist[i]) == 5]
            n += 1

    def getMatches(self, a: str, b: str) -> int:
        return sum(c1 == c2 for c1, c2 in zip(a, b))