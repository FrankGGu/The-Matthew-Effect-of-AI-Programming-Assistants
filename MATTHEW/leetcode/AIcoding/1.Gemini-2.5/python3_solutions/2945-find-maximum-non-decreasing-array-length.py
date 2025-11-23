class Solution:
    def findMaximumLength(self, nums: list[int]) -> int:
        stack = []  # Stores (value, length) pairs.
                    # 'value' is the current element, 'length' is the accumulated length
                    # of a non-decreasing sequence ending with 'value'.
                    # The 'value's in the stack are maintained in a strictly increasing order.
        max_len = 0 # Stores the maximum length found so far

        for num in nums:
            current_len = 1  # The current number itself forms a sequence of length 1

            # While the stack is not empty and the current number can extend or merge
            # with the sequence represented by the top of the stack:
            # This condition (stack[-1][0] <= num) means 'num' can be appended to
            # the sequence ending with stack[-1][0], or it can "absorb" it
            # due to the problem's operation (e.g., [A, B] -> [B, B] if A <= B).
            while stack and stack[-1][0] <= num:
                # Pop the previous segment (value, length) from the stack.
                # Its length is added to current_len, as 'num' effectively extends
                # or replaces this segment.
                prev_val, prev_len = stack.pop()
                current_len += prev_len

            # Push the current number and its accumulated length onto the stack.
            # If the loop above ran, current_len includes lengths of absorbed segments.
            # If the loop didn't run (i.e., stack is empty or stack[-1][0] > num),
            # then 'num' starts a new sequence of length 1 (or more if it absorbed
            # previous elements that were smaller than it but not smaller than stack[-1][0]).
            stack.append((num, current_len))

            # Update the overall maximum length found across all possible sequences.
            max_len = max(max_len, current_len)

        return max_len