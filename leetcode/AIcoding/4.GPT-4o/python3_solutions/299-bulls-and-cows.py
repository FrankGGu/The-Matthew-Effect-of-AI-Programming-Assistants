class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        bulls = sum(s == g for s, g in zip(secret, guess))
        secret_count = collections.Counter(secret)
        guess_count = collections.Counter(guess)
        cows = sum((secret_count & guess_count).values()) - bulls
        return f"{bulls}A{cows}B"