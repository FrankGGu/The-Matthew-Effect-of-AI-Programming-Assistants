class Solution:
    def minimumCost(self, nums: List[int]) -> int:
        def is_palindrome(x):
            s = str(x)
            return s == s[::-1]

        def cost(p, nums):
            return sum(abs(num - p) for num in nums)

        n = len(nums)
        nums.sort()
        min_cost = float('inf')

        for i in range(1, n - 1):
            for j in range(i, n):
                mid = (nums[i] + nums[j]) // 2
                for k in range(-100, 101):
                    candidate = mid + k
                    if is_palindrome(candidate):
                        min_cost = min(min_cost, cost(candidate, nums))

        return min_cost