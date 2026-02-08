class Solution:
    def beautifulSubsets(self, nums: List[int], k: int) -> int:
        from collections import Counter

        count = 0
        n = len(nums)
        nums.sort()

        def backtrack(index, current):
            nonlocal count
            if index == n:
                return
            # Exclude the current number
            backtrack(index + 1, current)
            # Include the current number, check if it forms a beautiful subset
            if current and abs(current[-1] - nums[index]) == k:
                return
            backtrack(index + 1, current + [nums[index]])
            count += 1

        backtrack(0, [])
        return count - 1  # Exclude the empty subset