class Solution:
    def printVertically(self, s: str) -> list[str]:
        words = s.split(' ')

        max_len = 0
        for word in words:
            max_len = max(max_len, len(word))

        result_chars = [[] for _ in range(max_len)]

        for j in range(max_len):
            for i in range(len(words)):
                if j < len(words[i]):
                    result_chars[j].append(words[i][j])
                else:
                    result_chars[j].append(' ')

        result_strings = []
        for char_list in result_chars:
            result_strings.append("".join(char_list).rstrip())

        return result_strings