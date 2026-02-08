class Solution:
    def squareFreeSubsets(self, nums: List[int]) -> int:
        from math import gcd
        from functools import lru_cache

        def is_square_free(x):
            if x < 2: return True
            for i in range(2, int(x**0.5) + 1):
                if x % (i * i) == 0:
                    return False
            return True

        @lru_cache(None)
        def count(index, product):
            if index == len(nums):
                return 1

            # Exclude current number
            total = count(index + 1, product)

            # Include current number if it's square-free
            if is_square_free(nums[index]) and gcd(product, nums[index]) == 1:
                total += count(index + 1, product * nums[index])

            return total

        return (count(0, 1) - 1) % (10**9 + 7)