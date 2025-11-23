class Solution:
    def freqAlphabets(self, s: str) -> str:
        result = []
        i = len(s) - 1
        while i >= 0:
            if s[i] == '#':
                result.append(chr(int(s[i-2:i]) + 96))
                i -= 3
            else:
                result.append(chr(int(s[i]) + 96))
                i -= 1
        return ''.join(result[::-1])