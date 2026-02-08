def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)

class Solution:
    def countBeautifulPairs(self, nums: list[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                if gcd(int(str(nums[i])[0]), nums[j] % 10) == 1:
                    count += 1
        return count