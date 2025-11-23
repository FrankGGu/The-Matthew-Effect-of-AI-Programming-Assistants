import math

class Solution:
    def find132pattern(self, nums: list[int]) -> bool:
        n = len(nums)
        if n < 3:
            return False

        # s3 will store the '3' in the 132 pattern (nums[k] in the problem statement, i.e., the middle element).
        # It is initialized to negative infinity because we are looking for nums[i] < s3.
        s3 = -math.inf 

        # stack will store potential '2's in the 132 pattern (nums[j] in the problem statement, i.e., the largest element).
        # Elements are pushed in decreasing order.
        # When iterating from right to left, elements on the stack are to the right of the current_num.
        stack = [] 

        # Iterate from right to left. current_num is nums[i] from the problem statement (the '1', i.e., the smallest element).
        for i in range(n - 1, -1, -1):
            current_num = nums[i]

            # Condition 1: nums[i] < nums[k]
            # If current_num (nums[i]) is less than s3 (nums[k]), we have found the first part of the pattern.
            # We already know s3 (nums[k]) < nums[j] for some nums[j] because of how s3 is updated (from stack.pop()).
            # So, we have nums[i] < nums[k] < nums[j].
            # The indices are also implicitly correct:
            #   'i' is the current loop index.
            #   'k' (index of s3) must be greater than 'i' because s3 is set from elements to the right of 'i'.
            #   'j' (index of the nums[j] that caused s3 to be set) must be greater than 'k'.
            # Thus, i < k < j is satisfied.
            if current_num < s3:
                return True

            # Condition 2: nums[k] < nums[j]
            # While stack is not empty and current_num is greater than the top of the stack:
            #   stack[-1] is a potential nums[j] (the '2'). Let's call it val_j.
            #   If current_num (nums[i]) > val_j (nums[j]), then val_j cannot be the '2' for current_num as '1'
            #   because nums[i] < nums[j] is required.
            #   However, val_j (nums[j]) is to the right of current_num (nums[i]), and val_j < current_num.
            #   This val_j (nums[j]) is a candidate for s3 (nums[k]).
            #   We want the largest possible s3 that is still smaller than some nums[j] (which would be the current_num or elements remaining on stack).
            #   So, we update s3 with the maximum of current s3 and val_j.
            #   This effectively sets s3 to the largest nums[k] found so far such that nums[k] has a nums[j] to its right (current_num or other stack elements) that is greater than nums[k].
            while stack and current_num > stack[-1]:
                s3 = max(s3, stack.pop())

            # Condition 3: nums[i] < nums[j] (for future '1's)
            # Push current_num onto the stack.
            # This current_num is a potential '2' (nums[j]) for numbers to its left (future '1's).
            # The stack maintains elements in decreasing order.
            stack.append(current_num)

        return False