class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        wordSet = set(wordDict)
        memo = {}

        def backtrack(s):
            if s in memo:
                return memo[s]
            if not s:
                return [""]
            res = []
            for i in range(1, len(s)+1):
                word = s[:i]
                if word in wordSet:
                    for sentence in backtrack(s[i:]):
                        if sentence:
                            res.append(word + " " + sentence)
                        else:
                            res.append(word)
            memo[s] = res
            return res

        return backtrack(s)