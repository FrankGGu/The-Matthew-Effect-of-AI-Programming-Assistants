class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        res = []
        for i in range(n):
            remaining_positions = n - i - 1
            remaining_sum = k - remaining_positions
            if remaining_sum >= 26:
                res.append('z')
                k -= 26
            else:
                char = chr(ord('a') + remaining_sum - 1)
                res.append(char)
                k -= remaining_sum
        return ''.join(res[::-1])