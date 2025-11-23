class Solution:
    def largestPalindrome(self, n: int, k: int) -> int:
        if n == 1:
            return 9 if k <= 9 else -1
        max_num = 10**n - 1
        min_num = 10**(n - 1)
        for left in range(max_num, min_num - 1, -1):
            s = str(left)
            candidate = int(s + s[::-1])
            if candidate % k == 0:
                return candidate
        return -1