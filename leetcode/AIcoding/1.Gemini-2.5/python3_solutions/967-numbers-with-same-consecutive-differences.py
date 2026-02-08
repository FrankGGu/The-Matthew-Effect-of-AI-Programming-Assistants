class Solution:
    def numsSameConsecDiff(self, n: int, k: int) -> list[int]:
        if n == 1:
            return [i for i in range(10)]

        current_nums = [i for i in range(1, 10)]

        for _ in range(n - 1):
            next_nums = []
            for num in current_nums:
                last_digit = num % 10

                next_digit_plus_k = last_digit + k
                if 0 <= next_digit_plus_k <= 9:
                    next_nums.append(num * 10 + next_digit_plus_k)

                if k != 0:
                    next_digit_minus_k = last_digit - k
                    if 0 <= next_digit_minus_k <= 9:
                        next_nums.append(num * 10 + next_digit_minus_k)
            current_nums = next_nums

        return current_nums