class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        row1 = set("qwertyuiop")
        row2 = set("asdfghjkl")
        row3 = set("zxcvbnm")
        result = []
        for word in words:
            w = set(word.lower())
            if w.issubset(row1) or w.issubset(row2) or w.issubset(row3):
                result.append(word)
        return result