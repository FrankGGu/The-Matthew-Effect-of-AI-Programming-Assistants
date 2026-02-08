class Solution:
    def findEncryptedString(self, s: str, n: int) -> str:
        if n == 0:
            return s
        length = len(s)
        s = list(s)

        for _ in range(n):
            new_s = [''] * length
            mid = (length + 1) // 2

            # Fill in the first half
            new_s[:mid] = s[::2]
            # Fill in the second half
            new_s[mid:] = s[1::2]

            s = new_s

        return ''.join(s)