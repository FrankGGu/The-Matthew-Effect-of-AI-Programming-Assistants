class Solution:
    def beautifulSubsets(self, nums: list[int], k: int) -> int:
        count = 0
        def backtrack(index, subset):
            nonlocal count
            count += 1
            for i in range(index, len(nums)):
                valid = True
                for num in subset:
                    if abs(nums[i] - num) == k:
                        valid = False
                        break
                if valid:
                    backtrack(i + 1, subset + [nums[i]])

        backtrack(0, [])
        return count - 1