class Solution:
    def nextGreaterElements(self, nums: list[int]) -> list[int]:
        n = len(nums)
        result = [-1] * n
        stack = [] # Stores elements (values) that are potential next greater elements

        # Iterate twice the length of the array from right to left
        # This simulates a circular array by processing elements from the "second pass" first,
        # which helps find NGE for elements in the "first pass" that wrap around.
        for i in range(2 * n - 1, -1, -1):
            current_num = nums[i % n]

            # Pop elements from the stack that are less than or equal to current_num.
            # These elements cannot be the next greater element for current_num
            # or any elements to its left (which are yet to be processed).
            while stack and stack[-1] <= current_num:
                stack.pop()

            # If we are processing an element from the original array (i.e., i < n)
            # and the stack is not empty, then the top of the stack is the NGE for nums[i % n].
            if i < n:
                if stack:
                    result[i] = stack[-1]

            # Push the current_num onto the stack.
            stack.append(current_num)

        return result