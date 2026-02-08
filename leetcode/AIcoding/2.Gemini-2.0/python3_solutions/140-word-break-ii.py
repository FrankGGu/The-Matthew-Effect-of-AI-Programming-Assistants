class Solution:
    def wordBreak(self, s: str, wordDict: list[str]) -> list[str]:
        word_set = set(wordDict)
        memo = {}

        def backtrack(start):
            if start in memo:
                return memo[start]

            if start == len(s):
                return [""]

            result = []
            for end in range(start + 1, len(s) + 1):
                word = s[start:end]
                if word in word_set:
                    next_sentences = backtrack(end)
                    for sentence in next_sentences:
                        if sentence:
                            result.append(word + " " + sentence)
                        else:
                            result.append(word)

            memo[start] = result
            return result

        return backtrack(0)