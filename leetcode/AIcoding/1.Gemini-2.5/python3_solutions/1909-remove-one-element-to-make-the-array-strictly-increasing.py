from typing import List

class Solution:
    def canBeIncreasing(self, nums: List[int]) -> bool:
        violations = 0
        violation_idx = -1 

        for i in range(len(nums) - 1):
            if nums[i] >= nums[i+1]:
                violations += 1
                violation_idx = i

        if violations == 0:
            return True

        if violations > 1:
            return False

        # If violations == 1, we need to check if removing one of the two elements involved in the violation fixes the array.
        # The violation is at nums[violation_idx] >= nums[violation_idx+1].

        # Option 1: Remove nums[violation_idx]
        # Check if the array becomes strictly increasing after removing nums[violation_idx].
        # This means checking if nums[violation_idx-1] < nums[violation_idx+1].
        # Handle boundary case: if violation_idx is 0, removing nums[0] means there's no element before nums[1] to check against.
        can_remove_left = False
        if violation_idx == 0:
            can_remove_left = True
        else:
            if nums[violation_idx-1] < nums[violation_idx+1]:
                can_remove_left = True

        # Option 2: Remove nums[violation_idx+1]
        # Check if the array becomes strictly increasing after removing nums[violation_idx+1].
        # This means checking if nums[violation_idx] < nums[violation_idx+2].
        # Handle boundary case: if violation_idx+1 is the last element, removing nums[len(nums)-1] means there's no element after nums[len(nums)-2] to check against.
        can_remove_right = False
        if violation_idx + 1 == len(nums) - 1:
            can_remove_right = True
        else:
            if nums[violation_idx] < nums[violation_idx+2]:
                can_remove_right = True

        return can_remove_left or can_remove_right