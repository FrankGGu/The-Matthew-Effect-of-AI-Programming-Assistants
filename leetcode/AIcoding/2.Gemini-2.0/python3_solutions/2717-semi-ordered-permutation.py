class Solution:
    def semiOrderedPermutation(self, nums: List[int]) -> int:
        n = len(nums)
        first_index = nums.index(1)
        last_index = nums.index(n)

        if first_index < last_index:
            return first_index + (n - 1 - last_index)
        else:
            return first_index + (n - 1 - last_index) - 1