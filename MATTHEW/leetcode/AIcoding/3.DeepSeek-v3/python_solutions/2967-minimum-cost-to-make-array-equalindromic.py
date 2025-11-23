class Solution:
    def minimumCost(self, nums: List[int]) -> int:
        def is_palindrome(x):
            s = str(x)
            return s == s[::-1]

        nums.sort()
        median = nums[len(nums) // 2]

        def find_closest_palindrome(target):
            lower = target
            while lower >= 0 and not is_palindrome(lower):
                lower -= 1
            higher = target
            while not is_palindrome(higher):
                higher += 1
            if lower < 0:
                return higher
            if target - lower <= higher - target:
                return lower
            else:
                return higher

        palindrome = find_closest_palindrome(median)

        total_cost = 0
        for num in nums:
            total_cost += abs(num - palindrome)

        return total_cost