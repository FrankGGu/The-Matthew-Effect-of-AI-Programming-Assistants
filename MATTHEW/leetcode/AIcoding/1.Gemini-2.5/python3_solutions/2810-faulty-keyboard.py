class Solution:
    def finalString(self, s: str) -> str:
        result_chars = []
        for char in s:
            if char == 'i':
                result_chars.reverse()
            else:
                result_chars.append(char)
        return "".join(result_chars)