class Solution:
    def kthPalindrome(self, queries: List[int], intLength: int) -> List[int]:
        result = []
        half_length = (intLength + 1) // 2
        start = 10 ** (half_length - 1)
        end = 10 ** half_length - 1

        for query in queries:
            num = start + query - 1
            if num > end:
                result.append(-1)
            else:
                half = str(num)
                if intLength % 2 == 0:
                    palindrome = half + half[::-1]
                else:
                    palindrome = half + half[:-1][::-1]
                result.append(int(palindrome))
        return result