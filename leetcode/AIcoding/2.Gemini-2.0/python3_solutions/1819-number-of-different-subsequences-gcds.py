def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)

class Solution:
    def countDifferentSubsequenceGCDs(self, nums: list[int]) -> int:
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