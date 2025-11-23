class Solution:
    def breakPalindrome(self, palindrome: str) -> str:
        n = len(palindrome)

        if n == 1:
            return ""

        s_list = list(palindrome)

        for i in range(n // 2):
            if s_list[i] != 'a':
                s_list[i] = 'a'
                return "".join(s_list)

        s_list[n - 1] = 'b'
        return "".join(s_list)