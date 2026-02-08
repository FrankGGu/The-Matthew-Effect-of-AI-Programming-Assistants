import math

class Solution:
    def findDifferentSubsequencesGCDs(self, nums: list[int]) -> int:
        MAX_VAL = 200000

        present = [False] * (MAX_VAL + 1)
        for num in nums:
            present[num] = True

        count = 0
        for g in range(1, MAX_VAL + 1):
            current_gcd = 0
            for multiple in range(g, MAX_VAL + 1, g):
                if present[multiple]:
                    if current_gcd == 0:
                        current_gcd = multiple
                    else:
                        current_gcd = math.gcd(current_gcd, multiple)

            if current_gcd == g:
                count += 1

        return count