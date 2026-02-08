class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        even = 1
        odd = 0
        ans = 0
        for num in arr:
            if num % 2 == 0:
                even += 1
            else:
                temp = even
                even = odd
                odd = temp + 1
            ans = (ans + odd) % MOD
        return ans