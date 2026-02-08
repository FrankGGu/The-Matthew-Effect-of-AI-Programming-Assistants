class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        row1 = set("qwertyuiop")
        row2 = set("asdfghjkl")
        row3 = set("zxcvbnm")
        res = []
        for word in words:
            lower_word = word.lower()
            if set(lower_word).issubset(row1) or set(lower_word).issubset(row2) or set(lower_word).issubset(row3):
                res.append(word)
        return res