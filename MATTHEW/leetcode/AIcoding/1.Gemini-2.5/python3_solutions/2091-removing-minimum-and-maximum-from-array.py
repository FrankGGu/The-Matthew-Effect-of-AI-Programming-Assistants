class Solution:
    def minimumDeletions(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 1:
            return 1

        min_val = float('inf')
        max_val = float('-inf')
        min_idx = -1
        max_idx = -1

        for i in range(n):
            if nums[i] < min_val:
                min_val = nums[i]
                min_idx = i
            if nums[i] > max_val:
                max_val = nums[i]
                max_idx = i

        # 'left_target_idx' will be the index of the element that is closer to the left end (index 0)
        # 'right_target_idx' will be the index of the element that is closer to the right end (index n-1)
        # among the min_idx and max_idx.
        left_target_idx = min(min_idx, max_idx)
        right_target_idx = max(min_idx, max_idx)

        # Option 1: Remove both from the left side
        # This means deleting all elements from index 0 up to right_target_idx (inclusive).
        # The number of deletions is (right_target_idx + 1).
        deletions_from_left = right_target_idx + 1

        # Option 2: Remove both from the right side
        # This means deleting all elements from index left_target_idx up to n-1 (inclusive).
        # The number of deletions is (n - left_target_idx).
        deletions_from_right = n - left_target_idx

        # Option 3: Remove one from the left and one from the right
        # This means deleting elements from index 0 up to left_target_idx (inclusive)
        # AND deleting elements from index right_target_idx up to n-1 (inclusive).
        # The number of deletions is (left_target_idx + 1) + (n - right_target_idx).
        deletions_from_both_sides = (left_target_idx + 1) + (n - right_target_idx)

        return min(deletions_from_left, deletions_from_right, deletions_from_both_sides)