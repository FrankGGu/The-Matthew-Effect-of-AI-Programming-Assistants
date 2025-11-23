class Solution:
    def superpalindromesInRange(self, left: str, right: str) -> int:
        L = int(left)
        R = int(right)
        MAGIC = 10**5
        count = 0

        def is_palindrome(s):
            return s == s[::-1]

        for k in range(1, MAGIC):
            s = str(k)
            t = s + s[:-1][::-1]
            num = int(t) ** 2
            if num > R:
                break
            if num >= L and is_palindrome(str(num)):
                count += 1

        for k in range(1, MAGIC):
            s = str(k)
            t = s + s[::-1]
            num = int(t) ** 2
            if num > R:
                break
            if num >= L and is_palindrome(str(num)):
                count += 1

        return count