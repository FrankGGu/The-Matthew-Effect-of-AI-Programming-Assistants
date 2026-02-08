class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        rows = set("qwertyuiop") | set("asdfghjkl") | set("zxcvbnm")
        result = []
        for word in words:
            if set(word.lower()).issubset(rows):
                result.append(word)
        return result