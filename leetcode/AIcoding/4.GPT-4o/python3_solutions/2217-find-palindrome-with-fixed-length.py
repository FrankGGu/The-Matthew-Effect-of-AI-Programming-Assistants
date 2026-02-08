class Solution:
    def palindrome(self, n: int, k: int) -> List[int]:
        start = 10**(k-1)
        end = 10**k
        result = []

        for i in range(start, end):
            s = str(i)
            if s == s[::-1]:
                result.append(i)

        return result