class Solution:
    def numberOfUniqueGoodSubsequences(self, s: str) -> int:
        end_with_zero = 0
        end_with_one = 0
        mod = 10**9 + 7
        for char in s:
            if char == '0':
                end_with_zero = (end_with_zero + end_with_one) % mod
            else:
                end_with_one = (end_with_zero + end_with_one + 1) % mod

        if '0' in s:
            return (end_with_zero + end_with_one + 1) % mod
        else:
            return (end_with_zero + end_with_one) % mod