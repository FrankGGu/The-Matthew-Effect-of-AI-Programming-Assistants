class Solution:
    def minimumTimeToInitialState(self, word: str, k: int) -> int:
        n = len(word)
        for t in range(1, (n // k) + 2):
            remaining = t * k
            if remaining >= n:
                return t
            match = True
            for i in range(remaining, n):
                if word[i] != word[i - remaining]:
                    match = False
                    break
            if match:
                return t
        return -1