class Solution:
    def largestPalindrome(self, n: int) -> int:
        if n == 1:
            return 9
        max_num = 10**n - 1
        min_num = 10**(n-1)
        for left in range(max_num, min_num - 1, -1):
            palindrome = int(str(left) + str(left)[::-1])
            for i in range(max_num, min_num - 1, -1):
                if palindrome // i > max_num:
                    break
                if palindrome % i == 0:
                    return palindrome % 1000000007
        return -1