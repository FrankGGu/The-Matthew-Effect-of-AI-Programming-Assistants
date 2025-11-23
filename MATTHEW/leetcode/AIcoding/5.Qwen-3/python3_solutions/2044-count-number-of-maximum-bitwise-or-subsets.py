class Solution:
    def countMaxOrSubsets(self, nums: List[int]) -> int:
        max_or = 0
        n = len(nums)
        for i in range(n):
            max_or |= nums[i]

        self.count = 0

        def backtrack(index, current_or):
            if index == n:
                if current_or == max_or:
                    self.count += 1
                return
            backtrack(index + 1, current_or)
            backtrack(index + 1, current_or | nums[index])

        backtrack(0, 0)
        return self.count