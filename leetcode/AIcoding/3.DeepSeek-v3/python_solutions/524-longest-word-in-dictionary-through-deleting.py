class Solution:
    def findLongestWord(self, s: str, dictionary: List[str]) -> str:
        def is_subsequence(word, s):
            it = iter(s)
            return all(c in it for c in word)

        dictionary.sort(key=lambda x: (-len(x), x))
        for word in dictionary:
            if is_subsequence(word, s):
                return word
        return ""