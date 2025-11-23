class Solution:
    def minimumTimeToInitialState(self, word: str, k: int) -> int:
        n = len(word)
        count = 0
        i = k
        while i < n:
            if word[i:] == word[:n - i]:
                return count + 1
            else:
                i += k
                count += 1
        return count + 1