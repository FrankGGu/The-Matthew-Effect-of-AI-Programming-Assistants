from math import gcd

class Solution:
    def countDifferentSubsequencesGCDs(self, nums: list[int]) -> int:
        max_num = max(nums)
        present = [False] * (max_num + 1)
        for num in nums:
            present[num] = True

        count = 0
        for i in range(1, max_num + 1):
            g = 0
            for j in range(i, max_num + 1, i):
                if present[j]:
                    g = gcd(g, j)
            if g == i:
                count += 1

        return count