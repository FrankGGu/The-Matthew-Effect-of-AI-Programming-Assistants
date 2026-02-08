class Solution:
    def countSymmetricIntegers(self, low: int, high: int) -> int:
        count = 0
        for num in range(low, high + 1):
            s_num = str(num)
            length = len(s_num)

            if length % 2 != 0:
                continue

            mid = length // 2

            first_half_sum = 0
            for i in range(mid):
                first_half_sum += int(s_num[i])

            second_half_sum = 0
            for i in range(mid, length):
                second_half_sum += int(s_num[i])

            if first_half_sum == second_half_sum:
                count += 1

        return count