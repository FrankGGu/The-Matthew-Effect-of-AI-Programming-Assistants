class Solution:
    def maximumSwap(self, num: int) -> int:
        s_digits = list(str(num))
        n = len(s_digits)

        for i in range(n):
            max_digit = s_digits[i]
            max_idx = i

            for j in range(n - 1, i, -1):
                if s_digits[j] > max_digit:
                    max_digit = s_digits[j]
                    max_idx = j

            if max_idx != i:
                s_digits[i], s_digits[max_idx] = s_digits[max_idx], s_digits[i]
                return int("".join(s_digits))

        return num