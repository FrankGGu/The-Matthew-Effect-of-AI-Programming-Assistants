class Solution:
    def minimumTimeToInitialState(self, word: str, speed: int) -> int:
        n = len(word)
        prefix = [0] * n
        for i in range(1, n):
            j = prefix[i - 1]
            while j > 0 and word[i] != word[j]:
                j = prefix[j - 1]
            if word[i] == word[j]:
                j += 1
            prefix[i] = j
        res = n
        for i in range(1, n):
            if prefix[i] == 0:
                res = min(res, i)
        return (n - res) // speed + (1 if (n - res) % speed else 0)