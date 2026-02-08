class Solution:
    def kthPalindrome(self, queries: List[int], intLength: int) -> List[int]:
        def get_palindrome(half, length):
            s = str(half)
            if len(s) > (length + 1) // 2:
                return -1
            s = s + s[:length // 2][::-1]
            return int(s)

        res = []
        half_len = (intLength + 1) // 2
        start = 10 ** (half_len - 1)
        end = 10 ** half_len - 1

        for q in queries:
            half = start + q - 1
            if half > end:
                res.append(-1)
            else:
                palindrome = get_palindrome(half, intLength)
                res.append(palindrome)
        return res