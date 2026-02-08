import math

class Solution:
    def sumOfPower(self, nums: list[int], k: int, p: int, mod: int) -> int:
        n = len(nums)
        nums.sort()

        C = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n + 1):
            C[i][0] = 1
            for j in range(1, i + 1):
                C[i][j] = (C[i - 1][j - 1] + C[i - 1][j]) % mod

        total_sum = 0

        for i in range(n):
            for j in range(i, n):
                if k == 1:
                    continue

                num_middle_elements = j - i - 1
                elements_to_choose = k - 2

                if num_middle_elements >= elements_to_choose:
                    count = C[num_middle_elements][elements_to_choose]

                    diff = nums[j] - nums[i]
                    power_val = pow(diff, p, mod)

                    total_sum = (total_sum + count * power_val) % mod

        return total_sum