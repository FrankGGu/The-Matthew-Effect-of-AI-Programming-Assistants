class Solution:
    def findProductsOfElements(self, nums: List[int]) -> List[int]:
        MOD = 10**9 + 7
        n = len(nums)
        left = [1] * n
        right = [1] * n
        for i in range(1, n):
            left[i] = (left[i - 1] * nums[i - 1]) % MOD
        for i in range(n - 2, -1, -1):
            right[i] = (right[i + 1] * nums[i + 1]) % MOD
        result = [(left[i] * right[i]) % MOD for i in range(n)]
        return result