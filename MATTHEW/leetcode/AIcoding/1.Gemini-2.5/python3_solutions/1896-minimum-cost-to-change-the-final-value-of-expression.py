class Solution:
    def minCostToChangeFinalValue(self, expression: str) -> int:

        # State for each subexpression: (actual_value, cost_to_make_0, cost_to_make_1)
        # actual_value: The boolean value (0 or 1) if no changes are made.
        # cost_to_make_0: Minimum cost to make the subexpression evaluate to 0.
        # cost_to_make_1: Minimum cost to make the subexpression evaluate to 1.

        def apply_op(left_state, op_char, right_state):
            l_val, lc0, lc1 = left_state
            r_val, rc0, rc1 = right_state

            # Calculate actual_value for the combined expression
            new_actual_val = -1 
            if op_char == '&':
                new_actual_val = l_val & r_val
            elif op_char == '|':
                new_actual_val = l_val | r_val

            # Calculate new_c0 and new_c1 (min costs to make result 0 or 1)
            new_c0, new_c1 = 0, 0 

            if op_char == '&':
                # Option 1: Operator remains '&'
                # To make result 0: (L=0, R=0) or (L=0, R=1) or (L=1, R=0)
                cost0_if_and = min(lc0 + rc0, lc0 + rc1, lc1 + rc0)
                # To make result 1: (L=1, R=1)
                cost1_if_and = lc1 + rc1

                # Option 2: Operator changes to '|' (cost +1 for operator change)
                # To make result 0: (L=0, R=0)
                cost0_if_or_changed = lc0 + rc0 + 1
                # To make result 1: (L=1, R=1) or (L=0, R=1) or (L=1, R=0)
                cost1_if_or_changed = min(lc1 + rc1, lc0 + rc1, lc1 + rc0) + 1

                new_c0 = min(cost0_if_and, cost0_if_or_changed)
                new_c1 = min(cost1_if_and, cost1_if_or_changed)

            elif op_char == '|':
                # Option 1: Operator remains '|'
                # To make result 0: (L=0, R=0)
                cost0_if_or = lc0 + rc0
                # To make result 1: (L=1, R=1) or (L=0, R=1) or (L=1, R=0)
                cost1_if_or = min(lc1 + rc1, lc0 + rc1, lc1 + rc0)

                # Option 2: Operator changes to '&' (cost +1 for operator change)
                # To make result 0: (L=0, R=0) or (L=0, R=1) or (L=1, R=0)
                cost0_if_and_changed = min(lc0 + rc0, lc0 + rc1, lc1 + rc0) + 1
                # To make result 1: (L=1, R=1)
                cost1_if_and_changed = lc1 + rc1 + 1

                new_c0 = min(cost0_if_or, cost0_if_and_changed)
                new_c1 = min(cost1_if_or, cost1_if_and_changed)

            return (new_actual_val, new_c0, new_c1)

        values_stack = [] # Stores (actual_value, cost_to_make_0, cost_to_make_1)
        operators_stack = [] # Stores operator characters

        for char in expression:
            if char == '(':
                pass 
            elif char == '0':
                values_stack.append((0, 0, 1)) # Actual=0, Cost to make 0 is 0, Cost to make 1 is 1
            elif char == '1':
                values_stack.append((1, 1, 0)) # Actual=1, Cost to make 0 is 1, Cost to make 1 is 0
            elif char == '&' or char == '|':
                operators_stack.append(char)
            elif char == ')':
                op = operators_stack.pop()
                right_state = values_stack.pop()
                left_state = values_stack.pop()

                result_state = apply_op(left_state, op, right_state)
                values_stack.append(result_state)

        # After processing the entire expression, the values_stack should have one element
        final_actual_val, final_c0, final_c1 = values_stack[0]

        # If the actual value is 0, we want to change it to 1, so return final_c1.
        # If the actual value is 1, we want to change it to 0, so return final_c0.
        if final_actual_val == 0:
            return final_c1
        else: # final_actual_val == 1
            return final_c0