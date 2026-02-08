class Solution:
    def minCost(self, s: str) -> int:
        n = len(s)

        # Calculate the minimum cost to make all characters '0'
        cost_to_make_all_zero = 0
        # current_flip_state_zero tracks if an odd number of suffix flips (Op2)
        # have been applied to the current character's position from previous operations.
        # 0 means the character is in its original or an even-flipped state.
        # 1 means the character is in an odd-flipped state.
        current_flip_state_zero = 0 

        for i in range(n):
            char_val = int(s[i])

            # Determine the effective character value at index i
            # If current_flip_state_zero is 1, the character is effectively flipped.
            effective_char_val = char_val
            if current_flip_state_zero == 1:
                effective_char_val = 1 - effective_char_val

            # If the effective character does not match the target '0'
            if effective_char_val == 1: # We want '0', but it's effectively '1'
                cost_to_make_all_zero += (i + 1)
                # To make s[i] '0', we must perform an operation.
                # Since Op1(i) and Op2(i) have the same cost (i+1),
                # we choose Op2(i) which flips s[i] and all subsequent characters.
                # This toggles the flip state for characters from i+1 onwards.
                current_flip_state_zero = 1 - current_flip_state_zero

        # Calculate the minimum cost to make all characters '1'
        cost_to_make_all_one = 0
        # Similar logic for target '1'
        current_flip_state_one = 0 

        for i in range(n):
            char_val = int(s[i])

            # Determine the effective character value at index i
            effective_char_val = char_val
            if current_flip_state_one == 1:
                effective_char_val = 1 - effective_char_val

            # If the effective character does not match the target '1'
            if effective_char_val == 0: # We want '1', but it's effectively '0'
                cost_to_make_all_one += (i + 1)
                # Toggle the flip state for subsequent characters
                current_flip_state_one = 1 - current_flip_state_one

        # The overall minimum cost is the minimum of making all '0's or all '1's
        return min(cost_to_make_all_zero, cost_to_make_all_one)