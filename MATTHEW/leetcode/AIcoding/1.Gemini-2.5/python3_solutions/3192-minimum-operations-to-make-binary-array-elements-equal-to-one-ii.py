class Solution:
    def minOperations(self, nums: list[int]) -> int:
        operations = 0
        flip_state = 0  # 0 means no active flip, 1 means an active flip is in effect

        for num in nums:
            # Calculate the effective value of the current element
            # If flip_state is 0, effective_num = num
            # If flip_state is 1, effective_num = 1 - num (or num ^ 1)
            effective_num = num ^ flip_state

            # If the effective value is 0, we need to perform an operation
            if effective_num == 0:
                operations += 1
                # A new flip starts here, so it changes the flip_state for subsequent elements
                flip_state = 1 - flip_state 
                # This is equivalent to flip_state ^= 1

        return operations