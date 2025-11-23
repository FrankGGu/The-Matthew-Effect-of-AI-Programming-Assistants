class Solution:
    def maxSum(self, nums: List[int], k: int) -> int:
        count = 0
        for num in nums:
            if num < 0:
                continue
            binary = bin(num)[2:]
            for bit in binary:
                if bit == '1':
                    count += 1

        result = 0
        mod = 10**9 + 7

        for _ in range(k):
            result = (result + pow(2, count - 1, mod)) % mod
            count -= 1

        return result