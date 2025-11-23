class Solution:
    def sumGame(self, num: str) -> bool:
        n = len(num)
        left_sum = 0
        right_sum = 0
        left_q = 0
        right_q = 0
        for i in range(n // 2):
            if num[i] == '?':
                left_q += 1
            else:
                left_sum += int(num[i])
        for i in range(n // 2, n):
            if num[i] == '?':
                right_q += 1
            else:
                right_sum += int(num[i])
        if (left_q + right_q) % 2 != 0:
            return True
        diff_q = abs(left_q - right_q)
        diff_sum = abs(left_sum - right_sum)
        if (diff_q // 2) * 9 == diff_sum:
            return False
        else:
            return True