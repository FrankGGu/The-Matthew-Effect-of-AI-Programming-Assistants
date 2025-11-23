class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        bulls = 0
        cows = 0
        secret_counts = {}
        guess_counts = {}

        for s, g in zip(secret, guess):
            if s == g:
                bulls += 1
            else:
                secret_counts[s] = secret_counts.get(s, 0) + 1
                guess_counts[g] = guess_counts.get(g, 0) + 1

        for char in guess_counts:
            cows += min(secret_counts.get(char, 0), guess_counts[char])

        return f"{bulls}A{cows}B"