class Solution:
    def licenseKeyFormatting(self, s: str, k: int) -> str:
        s = s.replace('-', '').upper()
        n = len(s)
        first_group_size = n % k or k
        formatted = [s[:first_group_size]]

        for i in range(first_group_size, n, k):
            formatted.append(s[i:i + k])

        return '-'.join(formatted)