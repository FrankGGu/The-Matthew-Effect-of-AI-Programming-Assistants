class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        prefix = 0
        even = 1
        odd = 0
        res = 0
        for num in arr:
            prefix += num
            if prefix % 2 == 1:
                res += even
                odd += 1
            else:
                res += odd
                even += 1
        return res % MOD