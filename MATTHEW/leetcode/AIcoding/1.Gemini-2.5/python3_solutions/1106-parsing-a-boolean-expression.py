class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        stack = []

        for char in expression:
            if char == 't':
                stack.append(True)
            elif char == 'f':
                stack.append(False)
            elif char in ('!', '&', '|'):
                stack.append(char)
            elif char == '(':
                stack.append('(') # Marker for start of arguments for an operator
            elif char == ')':
                # Evaluate the sub-expression
                args = []
                # Pop all boolean values until the matching '(' is found
                while stack and stack[-1] != '(':
                    args.append(stack.pop())

                # Pop the '(' marker
                stack.pop() 

                # The character before '(' must be the operator
                op = stack.pop()

                result = False # Default, will be overwritten
                if op == '!':
                    # For '!', there should be exactly one argument.
                    # The argument is at args[0] because it was popped last.
                    result = not args[0] 
                elif op == '&':
                    # For '&', all arguments must be True.
                    # The order of arguments in 'args' does not matter for all().
                    result = all(args)
                elif op == '|':
                    # For '|', at least one argument must be True.
                    # The order of arguments in 'args' does not matter for any().
                    result = any(args)

                # Push the result of the sub-expression back onto the stack
                stack.append(result)
            # Commas (',') are just separators and do not require stack operations.

        # After processing the entire expression, the stack should contain
        # a single boolean value which is the final result.
        return stack[0]