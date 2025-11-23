class Solution:
    def largestPalindrome(self, n: int) -> int:
        if n == 1:
            return 9
        upper_bound = 10 ** n - 1
        lower_bound = 10 ** (n - 1)
        max_number = upper_bound

        for i in range(max_number, lower_bound - 1, -1):
            palindrome = int(str(i) + str(i)[::-1])
            for j in range(max_number, int(palindrome ** 0.5) - 1, -1):
                if palindrome % j == 0 and palindrome // j <= max_number:
                    return palindrome % 1337
        return 0