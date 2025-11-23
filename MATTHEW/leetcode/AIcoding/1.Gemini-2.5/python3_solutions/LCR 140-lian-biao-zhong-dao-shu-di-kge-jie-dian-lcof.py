class Solution:
    def countSymmetricIntegers(self, low: int, high: int) -> int:
        count = 0
        for num in range(low, high + 1):
            s = str(num)
            n = len(s)

            if n % 2 == 0:
                half_len = n // 2

                sum_first_half = 0
                for i in range(half_len):
                    sum_first_half += int(s[i])

                sum_second_half = 0
                for i in range(half_len, n):
                    sum_second_half += int(s[i])

                if sum_first_half == sum_second_half:
                    count += 1

        return count