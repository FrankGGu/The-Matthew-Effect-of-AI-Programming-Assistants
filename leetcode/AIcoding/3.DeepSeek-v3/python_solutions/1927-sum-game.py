class Solution:
    def sumGame(self, num: str) -> bool:
        n = len(num)
        left_sum = 0
        left_q = 0
        right_sum = 0
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

        total_q = left_q + right_q
        if total_q == 0:
            return left_sum != right_sum

        if (left_q + right_q) % 2 == 1:
            return True

        return (left_sum - right_sum) != (right_q - left_q) * 9 // 2