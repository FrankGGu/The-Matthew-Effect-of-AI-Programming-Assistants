class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        bulls = 0

        secret_counts = [0] * 10
        guess_counts = [0] * 10

        n = len(secret)

        for i in range(n):
            if secret[i] == guess[i]:
                bulls += 1
            else:
                secret_counts[int(secret[i])] += 1
                guess_counts[int(guess[i])] += 1

        cows = 0
        for i in range(10):
            cows += min(secret_counts[i], guess_counts[i])

        return f"{bulls}A{cows}B"