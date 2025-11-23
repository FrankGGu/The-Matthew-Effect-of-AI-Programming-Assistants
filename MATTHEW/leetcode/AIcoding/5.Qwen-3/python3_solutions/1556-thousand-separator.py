class Solution:
    def thousandSeparator(self, n: int) -> str:
        s = str(n)
        result = []
        for i in range(len(s)):
            if (len(s) - i) % 3 == 0 and i != 0:
                result.append('.')
            result.append(s[i])
        return ''.join(result)