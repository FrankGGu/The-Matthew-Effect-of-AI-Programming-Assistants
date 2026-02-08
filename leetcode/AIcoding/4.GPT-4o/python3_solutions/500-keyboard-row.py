class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
        row_set = [set(row) for row in rows]

        def can_form(word):
            word_set = set(word.lower())
            for row in row_set:
                if word_set.issubset(row):
                    return True
            return False

        return [word for word in words if can_form(word)]