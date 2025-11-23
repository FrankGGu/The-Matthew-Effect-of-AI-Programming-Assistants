class Solution:
    def sumOfDigitDifferences(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        res = 0
        for i in range(n):
            s = str(nums[i])
            for j in range(i + 1, n):
                t = str(nums[j])
                diff = 0
                for k in range(min(len(s), len(t))):
                    if s[k] != t[k]:
                        diff += 1
                res += diff
        return res