class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        from collections import Counter

        bull = 0
        cow = 0
        secret_count = Counter()
        guess_count = Counter()

        for s, g in zip(secret, guess):
            if s == g:
                bull += 1
            else:
                secret_count[s] += 1
                guess_count[g] += 1

        for char in guess_count:
            cow += min(secret_count[char], guess_count[char])

        return f"{bull}A{cow}B"