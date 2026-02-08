class Solution:
    def findTwoNumbers(self, N: int) -> list[int]:
        sum_nums = N * (N + 1) // 2
        sum_squares = N * (N + 1) * (2 * N + 1) // 6

        b = (sum_squares - sum_nums * sum_nums) // (sum_nums - N)
        a = sum_nums - b

        return [a, b]