class Solution:
    def longestWord(self, words: List[str]) -> str:
        word_set = set(words)
        longest = ""

        for word in words:
            if len(word) > len(longest) or (len(word) == len(longest) and word < longest):
                if all(word[:k] in word_set for k in range(1, len(word))):
                    longest = word

        return longest