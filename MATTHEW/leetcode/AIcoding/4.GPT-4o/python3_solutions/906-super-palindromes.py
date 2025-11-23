class Solution:
    def superpalindromesInRange(self, L: str, R: str) -> int:
        def is_palindrome(x):
            return str(x) == str(x)[::-1]

        def count_super_palindromes(limit):
            count = 0
            for i in range(1, int(limit**0.5) + 1):
                s = str(i)
                palin = int(s + s[::-1])  # even length
                if palin > limit:
                    break
                if is_palindrome(palin * palin):
                    count += 1
                palin = int(s + s[-2::-1])  # odd length
                if palin > limit:
                    break
                if is_palindrome(palin * palin):
                    count += 1
            return count

        L = int(L)
        R = int(R)
        return count_super_palindromes(R) - count_super_palindromes(L - 1)