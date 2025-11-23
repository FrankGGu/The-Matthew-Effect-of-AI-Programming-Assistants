class Solution:
    def checkPossibility(self, nums: list[int]) -> bool:
        n = len(nums)
        if n <= 2:
            return True

        violations = 0
        violation_idx = -1

        for i in range(n - 1):
            if nums[i] > nums[i+1]:
                violations += 1
                violation_idx = i
                if violations > 1:
                    return False

        if violations == 0:
            return True

        # At this point, violations == 1.
        # The single violation is at index `violation_idx`, where nums[violation_idx] > nums[violation_idx + 1].

        # Option 1: Try to fix by changing nums[violation_idx]
        # This is possible if:
        # 1. violation_idx is 0 (no element before nums[0] to check)
        # OR
        # 2. nums[violation_idx - 1] <= nums[violation_idx + 1]
        #    (meaning we can decrease nums[violation_idx] to nums[violation_idx + 1]
        #     without violating the non-decreasing property with nums[violation_idx - 1])
        can_fix_by_modifying_current = (violation_idx == 0) or \
                                       (nums[violation_idx - 1] <= nums[violation_idx + 1])

        # Option 2: Try to fix by changing nums[violation_idx + 1]
        # This is possible if:
        # 1. violation_idx + 1 is the last element (no element after nums[n-1] to check)
        #    This means violation_idx == n - 2.
        # OR
        # 2. nums[violation_idx] <= nums[violation_idx + 2]
        #    (meaning we can increase nums[violation_idx + 1] to nums[violation_idx]
        #     without violating the non-decreasing property with nums[violation_idx + 2])
        can_fix_by_modifying_next = (violation_idx == n - 2) or \
                                    (nums[violation_idx] <= nums[violation_idx + 2])

        return can_fix_by_modifying_current or can_fix_by_modifying_next