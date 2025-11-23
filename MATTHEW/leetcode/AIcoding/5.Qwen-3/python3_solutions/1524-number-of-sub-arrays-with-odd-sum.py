class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        mod = 10**9 + 7
        even = 1
        odd = 0
        res = 0
        for num in arr:
            if num % 2 == 0:
                even += 1
            else:
                even, odd = odd, even + 1
            res = (res + odd) % mod
        return res