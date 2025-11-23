import math

class Solution:
    def countBeautifulPairs(self, nums: list[int]) -> int:
        n = len(nums)
        beautiful_pairs_count = 0

        def get_first_digit(num: int) -> int:
            while num >= 10:
                num //= 10
            return num

        for i in range(n):
            first_digit_i = get_first_digit(nums[i])
            for j in range(i + 1, n):
                last_digit_j = nums[j] % 10
                if math.gcd(first_digit_i, last_digit_j) == 1:
                    beautiful_pairs_count += 1

        return beautiful_pairs_count