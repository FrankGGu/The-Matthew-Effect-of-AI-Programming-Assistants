class Solution:
    def minimizeConcatenatedLength(self, words: list[str]) -> int:
        n = len(words)
        dp = {}

        def solve(idx, prefix_end, suffix_start):
            if idx == n:
                return 0

            if (idx, prefix_end, suffix_start) in dp:
                return dp[(idx, prefix_end, suffix_start)]

            word = words[idx]
            len_word = len(word)
            ans1 = len_word
            if word[0] == prefix_end:
                ans1 -= 1
            ans1 += solve(idx + 1, word[-1], suffix_start)

            ans2 = len_word
            if suffix_start == word[-1]:
                ans2 -= 1
            ans2 += solve(idx + 1, prefix_end, word[0])

            dp[(idx, prefix_end, suffix_start)] = min(ans1, ans2)
            return dp[(idx, prefix_end, suffix_start)]

        return len(words[0]) + solve(1, words[0][-1], words[0][0])