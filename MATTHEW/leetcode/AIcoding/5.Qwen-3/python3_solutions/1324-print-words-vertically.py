class Solution:
    def printWordsVertically(self, s: str) -> List[str]:
        words = s.split()
        max_len = max(len(word) for word in words)
        result = []
        for i in range(max_len):
            vertical_word = ''
            for word in words:
                if i < len(word):
                    vertical_word += word[i]
                else:
                    vertical_word += ' '
            result.append(vertical_word.strip())
        return result