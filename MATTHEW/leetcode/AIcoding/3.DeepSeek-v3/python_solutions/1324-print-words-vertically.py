class Solution:
    def printVertically(self, s: str) -> List[str]:
        words = s.split()
        max_len = max(len(word) for word in words)
        res = []
        for i in range(max_len):
            column = []
            for word in words:
                if i < len(word):
                    column.append(word[i])
                else:
                    column.append(' ')
            res.append(''.join(column).rstrip())
        return res