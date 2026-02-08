class Solution:
    def longestWord(self, words: list[str]) -> str:
        words.sort()
        longest = ""
        built = set()
        for word in words:
            if len(word) == 1 or word[:-1] in built:
                built.add(word)
                if len(word) > len(longest):
                    longest = word
        return longest