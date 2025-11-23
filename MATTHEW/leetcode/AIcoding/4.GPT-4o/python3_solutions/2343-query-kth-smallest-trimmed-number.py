class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        result = []
        for i in range(n):
            if k - (n - i) * 9 > 0:
                char = min(9, k - (n - i) * 1)
                result.append(str(char))
                k -= char
            else:
                result.append('1')
                k -= 1
        return ''.join(result)