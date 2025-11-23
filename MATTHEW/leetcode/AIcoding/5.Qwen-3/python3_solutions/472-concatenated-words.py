class Solution:
    def findAllConcatenatedWordsInADict(self, words):
        word_set = set(words)
        result = []

        def is_concatenated(word):
            if not word:
                return False
            dp = [False] * (len(word) + 1)
            dp[0] = True
            for i in range(1, len(word) + 1):
                for j in range(i):
                    if dp[j] and word[j:i] in word_set:
                        dp[i] = True
                        break
            return dp[-1]

        for word in words:
            if is_concatenated(word):
                result.append(word)
        return result