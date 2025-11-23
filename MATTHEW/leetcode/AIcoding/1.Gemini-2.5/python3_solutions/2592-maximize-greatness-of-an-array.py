class Solution:
    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        greatness = 0
        i = 0  # Pointer for elements of nums (as the base array)
        j = 0  # Pointer for elements of nums (as the permutation source)

        while j < len(nums):
            if nums[j] > nums[i]:
                # Found an element nums[j] that is greater than nums[i].
                # We can use nums[j] as perm[i].
                greatness += 1
                i += 1  # Move to the next element in the base array
                j += 1  # Move to the next element in the permutation source
            else:
                # nums[j] is not greater than nums[i].
                # We need a larger element for nums[i], so we only advance j.
                j += 1

        return greatness