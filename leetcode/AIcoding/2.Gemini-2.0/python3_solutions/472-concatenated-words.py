class Solution:
    def findAllConcatenatedWords(self, words: list[str]) -> list[str]:
        word_set = set(words)

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

            return dp[len(word)]

        result = []
        for word in words:
            if is_concatenated(word):
                result.append(word)

        result_filtered = []
        for word in result:
            word_set.remove(word)
            if is_concatenated(word):
                result_filtered.append(word)
            word_set.add(word)

        return result_filtered