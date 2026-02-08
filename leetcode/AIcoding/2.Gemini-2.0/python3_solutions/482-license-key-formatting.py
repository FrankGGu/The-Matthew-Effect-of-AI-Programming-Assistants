class Solution:
    def licenseKeyFormatting(self, s: str, k: int) -> str:
        s = s.replace('-', '').upper()
        n = len(s)
        first_group_len = n % k
        result = ""
        if first_group_len > 0:
            result += s[:first_group_len]
            if n > first_group_len:
                result += '-'

        for i in range(first_group_len, n, k):
            result += s[i:i+k]
            if i + k < n:
                result += '-'

        return result