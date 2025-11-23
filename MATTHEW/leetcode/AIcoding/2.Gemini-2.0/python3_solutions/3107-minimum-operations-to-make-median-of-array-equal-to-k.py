class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        less_k = 0
        greater_equal_k = 0
        for num in nums:
            if num < k:
                less_k += 1
            else:
                greater_equal_k += 1

        if n % 2 == 1:
            if greater_equal_k > (n + 1) // 2 - 1:
                return 0
            else:
                return (n + 1) // 2 - greater_equal_k
        else:
            if greater_equal_k >= n // 2:
                return 0
            else:
                return n // 2 - greater_equal_k + 1