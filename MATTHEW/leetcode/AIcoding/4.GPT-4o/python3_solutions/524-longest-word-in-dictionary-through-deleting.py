class Solution:
    def findLongestWord(self, s: str, dictionary: List[str]) -> str:
        def canForm(word):
            it = iter(s)
            return all(c in it for c in word)

        dictionary.sort(key=lambda x: (-len(x), x))
        for word in dictionary:
            if canForm(word):
                return word
        return ""