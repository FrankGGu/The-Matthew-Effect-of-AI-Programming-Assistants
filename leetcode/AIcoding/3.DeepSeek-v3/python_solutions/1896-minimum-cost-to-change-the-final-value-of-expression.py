class Solution:
    def minOperationsToFlip(self, expression: str) -> int:
        stack = []
        dp = []

        for c in expression:
            if c in '(&|':
                stack.append(c)
                dp.append(None)
            elif c == ')':
                # Pop until '(' is encountered
                temp_stack = []
                temp_dp = []
                while stack[-1] != '(':
                    temp_stack.append(stack.pop())
                    temp_dp.append(dp.pop())
                # Pop '('
                stack.pop()
                # Pop the corresponding dp (for '(')
                dp.pop()

                # Process the temp_stack and temp_dp
                while len(temp_stack) > 1:
                    op = temp_stack.pop()
                    left = temp_dp.pop()
                    right = temp_dp.pop()
                    new_val, new_cost = self.combine(left, right, op)
                    temp_stack.append(new_val)
                    temp_dp.append(new_cost)

                if temp_stack:
                    stack.append(temp_stack[0])
                    dp.append(temp_dp[0])
            else:  # '0' or '1'
                stack.append(int(c))
                dp.append((float('inf'), float('inf')))

        # Process the remaining stack and dp
        while len(stack) > 1:
            op = stack.pop(0)
            left = dp.pop(0)
            right = dp.pop(0)
            new_val, new_cost = self.combine(left, right, op)
            stack.insert(0, new_val)
            dp.insert(0, new_cost)

        return max(dp[0])

    def combine(self, left, right, op):
        if isinstance(left, tuple) and isinstance(right, tuple):
            # Both are dp tuples
            if op == '&':
                val = 0 if (left[0] == 0 or right[0] == 0) else 1
                cost = min(
                    left[1] + right[1],
                    (left[0] == 1) + right[1],
                    (right[0] == 1) + left[1],
                    (left[0] == 1) + (right[0] == 1)
                )
            elif op == '|':
                val = 1 if (left[0] == 1 or right[0] == 1) else 0
                cost = min(
                    left[1] + right[1],
                    (left[0] == 0) + right[1],
                    (right[0] == 0) + left[1],
                    (left[0] == 0) + (right[0] == 0)
                )
            return (val, cost)
        else:
            # One of them is a value (should not happen in correct parsing)
            pass