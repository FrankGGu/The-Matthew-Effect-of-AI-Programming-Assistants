class Solution:
    def minInteger(self, num: str, k: int) -> str:
        num = list(num)
        n = len(num)
        for i in range(n):
            if k <= 0:
                break
            min_digit = num[i]
            pos = i
            for j in range(i + 1, min(i + k + 1, n)):
                if num[j] < min_digit:
                    min_digit = num[j]
                    pos = j
            k -= pos - i
            for j in range(pos, i, -1):
                num[j], num[j - 1] = num[j - 1], num[j]
        return ''.join(num)