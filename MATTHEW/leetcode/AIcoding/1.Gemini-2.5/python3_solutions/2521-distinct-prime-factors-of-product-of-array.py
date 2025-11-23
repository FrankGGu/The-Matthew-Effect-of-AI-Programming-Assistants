class Solution:
    def distinctPrimeFactors(self, nums: list[int]) -> int:
        distinct_factors = set()

        for num in nums:
            d = 2
            temp_num = num
            while d * d <= temp_num:
                if temp_num % d == 0:
                    distinct_factors.add(d)
                    while temp_num % d == 0:
                        temp_num //= d
                d += 1
            if temp_num > 1:
                distinct_factors.add(temp_num)

        return len(distinct_factors)