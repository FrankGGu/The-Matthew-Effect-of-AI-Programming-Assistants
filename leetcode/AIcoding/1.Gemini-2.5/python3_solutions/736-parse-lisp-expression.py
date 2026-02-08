import collections

class Solution:
    def evaluate(self, expression: str) -> int:
        # scope_stack is a list of dictionaries, representing the current environment.
        # Each dictionary maps variable names (str) to their integer values.
        # The innermost scope is at the end of the list.
        self.scope_stack = [{}] # Start with a global scope, initially empty

        # Helper function to find the value of a variable in the current scope stack.
        # It searches from the innermost scope outwards.
        def find_value(var_name: str) -> int:
            for i in range(len(self.scope_stack) - 1, -1, -1):
                if var_name in self.scope_stack[i]:
                    return self.scope_stack[i][var_name]
            # Problem constraints guarantee valid Lisp expressions, so a variable will always be found.
            # This line should theoretically not be reached with valid input.
            return 0 

        # Helper function to tokenize the content of a parenthesized expression.
        # It correctly handles nested parentheses by tracking balance.
        # Example: "add 1 (mult 2 3)" -> ["add", "1", "(mult 2 3)"]
        def tokenize(s: str) -> list[str]:
            tokens = []
            balance = 0
            current_token_chars = []

            for char in s:
                if char == '(':
                    balance += 1
                elif char == ')':
                    balance -= 1

                # If a space is encountered and we are not inside a nested expression (balance == 0),
                # it marks the end of a token.
                if char == ' ' and balance == 0:
                    if current_token_chars: # Only add if current_token_chars is not empty (e.g., multiple spaces)
                        tokens.append("".join(current_token_chars))
                        current_token_chars = []
                else:
                    current_token_chars.append(char)

            # Add the last token after the loop finishes.
            if current_token_chars:
                tokens.append("".join(current_token_chars))

            return tokens

        # The main recursive evaluation function.
        def _eval(expr_str: str) -> int:
            # Case 1: Integer literal or variable.
            if expr_str[0] != '(':
                # Check if it's an integer (starts with digit or minus sign).
                if expr_str[0].isdigit() or expr_str[0] == '-':
                    return int(expr_str)
                else: # It must be a variable name.
                    return find_value(expr_str)

            # Case 2: Parenthesized expression (add, mult, or let).
            # Remove the outermost parentheses.
            expr_content = expr_str[1:-1] 

            # Tokenize the content to identify the operation and its arguments.
            tokens = tokenize(expr_content)

            op = tokens[0] # The first token is always the operation.

            if op == "add":
                # Evaluate the two arguments and return their sum.
                val1 = _eval(tokens[1])
                val2 = _eval(tokens[2])
                return val1 + val2

            elif op == "mult":
                # Evaluate the two arguments and return their product.
                val1 = _eval(tokens[1])
                val2 = _eval(tokens[2])
                return val1 * val2

            elif op == "let":
                # A 'let' expression introduces a new scope.
                new_scope = {}
                self.scope_stack.append(new_scope)

                # Process variable bindings: v1 e1 v2 e2 ... vn en
                # The loop iterates over pairs of (variable_name, expression_to_bind).
                # The last token is always the 'body' expression, so we stop before it.
                for i in range(1, len(tokens) - 1, 2):
                    var_name = tokens[i]
                    expr_to_bind = tokens[i+1]

                    # Evaluate the expression for the binding in the *current* (potentially extended) scope.
                    # This correctly handles cases like `(let x 2 y (add x 3) ...)` where `x` is available for `y`.
                    bound_value = _eval(expr_to_bind)

                    # Store the binding in the *new* scope.
                    new_scope[var_name] = bound_value

                # Evaluate the 'body' expression in the current (extended) scope.
                body_expr = tokens[-1]
                result = _eval(body_expr)

                # After evaluation, pop the 'let' scope to revert to the previous scope.
                self.scope_stack.pop()
                return result

        # Start the evaluation with the initial expression.
        return _eval(expression)