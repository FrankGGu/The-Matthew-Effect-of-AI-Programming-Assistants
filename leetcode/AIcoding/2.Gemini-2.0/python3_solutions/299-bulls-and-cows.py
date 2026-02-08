class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        bulls = 0
        cows = 0
        secret_counts = {}
        guess_counts = {}

        for i in range(len(secret)):
            if secret[i] == guess[i]:
                bulls += 1
            else:
                secret_counts[secret[i]] = secret_counts.get(secret[i], 0) + 1
                guess_counts[guess[i]] = guess_counts.get(guess[i], 0) + 1

        for digit, count in guess_counts.items():
            if digit in secret_counts:
                cows += min(count, secret_counts[digit])

        return f"{bulls}A{cows}B"