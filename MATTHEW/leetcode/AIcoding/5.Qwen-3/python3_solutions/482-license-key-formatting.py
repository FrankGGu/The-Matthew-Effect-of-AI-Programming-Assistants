class Solution:
    def licenseKeyFormatting(self, s: str) -> str:
        s = s.replace('-', '').upper()
        n = len(s)
        result = []
        for i in range(n):
            if i > 0 and (n - i) % 4 == 0:
                result.append('-')
            result.append(s[i])
        return ''.join(result)