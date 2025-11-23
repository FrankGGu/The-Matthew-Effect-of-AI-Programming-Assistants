class Solution:
    def countMaxOrSubsets(self, nums: List[int]) -> int:
        max_or = 0
        count = 0

        def backtrack(index, current_or):
            nonlocal count, max_or
            if index == len(nums):
                if current_or > max_or:
                    max_or = current_or
                    count = 1
                elif current_or == max_or:
                    count += 1
                return

            backtrack(index + 1, current_or | nums[index])
            backtrack(index + 1, current_or)

        backtrack(0, 0)
        return count