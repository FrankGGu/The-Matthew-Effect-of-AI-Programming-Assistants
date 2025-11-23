import math

class Solution:
    def subarrayGCD(self, nums: list[int], k: int) -> int:
        n = len(nums)
        count = 0

        for i in range(n):
            current_gcd = 0 
            for j in range(i, n):
                if nums[j] % k != 0:
                    break

                current_gcd = math.gcd(current_gcd, nums[j])

                if current_gcd == k:
                    count += 1
                elif current_gcd < k:
                    break

        return count