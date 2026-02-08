class Solution:
    def minTimeToType(self, word: str) -> int:
        res = len(word)
        curr = 'a'
        for char in word:
            diff = abs(ord(char) - ord(curr))
            res += min(diff, 26 - diff)
            curr = char
        return res