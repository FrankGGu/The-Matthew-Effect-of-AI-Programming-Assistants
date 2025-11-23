class Solution:
    def longestStrChain(self, words: List[str]) -> int:
        word_set = set(words)
        dp = {}

        def solve(word):
            if word in dp:
                return dp[word]

            max_len = 1
            for i in range(len(word)):
                new_word = word[:i] + word[i+1:]
                if new_word in word_set:
                    max_len = max(max_len, solve(new_word) + 1)

            dp[word] = max_len
            return max_len

        max_chain_len = 0
        for word in words:
            max_chain_len = max(max_chain_len, solve(word))

        return max_chain_len