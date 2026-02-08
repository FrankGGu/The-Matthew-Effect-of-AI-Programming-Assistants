import collections

class Solution:
    def basicCalculatorIV(self, expression: str, evalvars: list[str], evalints: list[int]) -> list[str]:
        val_map = dict(zip(evalvars, evalints))

        # Tokenize the expression string
        # Variables are guaranteed to be single lowercase English letters.
        def tokenize(s):
            i = 0
            n = len(s)
            while i < n:
                if s[i].isspace():
                    i += 1
                    continue
                if s[i].isdigit():
                    j = i
                    while j < n and s[j].isdigit():
                        j += 1
                    yield int(s[i:j]) # Numbers are integers
                    i = j
                elif s[i].isalpha(): # Variables are single letters
                    yield s[i]
                    i += 1
                else: # Operators or parentheses
                    yield s[i]
                    i += 1

        self.tokens = list(tokenize(expression))
        self.pos = 0 # Current position in the token list

        # Helper functions for token stream
        def peek():
            if self.pos < len(self.tokens):
                return self.tokens[self.pos]
            return None

        def consume():
            if self.pos < len(self.tokens):
                token = self.tokens[self.pos]
                self.pos += 1
                return token
            raise ValueError("Unexpected end of expression")

        # A polynomial is represented as a collections.Counter
        # Keys are tuples of sorted variable names (e.g., ('x',), ('x', 'y'), () for constant)
        # Values are integer coefficients.

        # Factor: NUMBER | VARIABLE | '(' expression ')'
        def parse_factor():
            token = peek()
            if token == '(':
                consume() # Consume '('
                poly = parse_expression()
                consume() # Consume ')'
                return poly
            elif isinstance(token, int): # A number literal
                consume()
                return collections.Counter({(): token}) # Constant term
            elif isinstance(token, str) and token.isalpha(): # A variable
                consume()
                var_name = token
                if var_name in val_map:
                    # If variable is evaluated, treat as a constant
                    return collections.Counter({(): val_map[var_name]})
                else:
                    # Otherwise, it's a variable term with coefficient 1
                    return collections.Counter({(var_name,): 1})
            else:
                raise ValueError(f"Unexpected token in parse_factor: {token}")

        # Term: factor ( '*' factor )*
        def parse_term():
            poly = parse_factor()
            while peek() == '*':
                consume() # Consume '*'
                other_poly = parse_factor()

                # Multiply two polynomials
                new_poly = collections.Counter()
                for vars1, coeff1 in poly.items():
                    for vars2, coeff2 in other_poly.items():
                        # Combine variable tuples and sort to ensure canonical representation
                        new_vars = tuple(sorted(vars1 + vars2))
                        new_poly[new_vars] += coeff1 * coeff2
                poly = new_poly
            return poly

        # Expression: term ( ( '+' | '-' ) term )*
        def parse_expression():
            poly = parse_term()
            while peek() in ('+', '-'):
                op = consume()
                other_poly = parse_term()
                if op == '+':
                    poly.update(other_poly) # Add coefficients
                else: # op == '-'
                    for vars_tuple, coeff in other_poly.items():
                        poly[vars_tuple] -= coeff # Subtract coefficients
            return poly

        # Start parsing from the top-level expression
        result_poly = parse_expression()

        # Format the output according to problem requirements
        output = []

        # Filter out terms with zero coefficients and prepare for sorting
        terms_to_sort = []
        for vars_tuple, coeff in result_poly.items():
            if coeff != 0:
                terms_to_sort.append((vars_tuple, coeff))

        # Custom sort key for terms:
        # 1. By degree (descending, so -len(vars_tuple))
        # 2. For same degree, by variable names alphabetically (using a joined string)
        def sort_key(item):
            vars_tuple, _ = item
            degree = len(vars_tuple)
            # Join variables with '*' for alphabetical comparison.
            # Example: ('x', 'y') -> "x*y", ('x', 'z') -> "x*z"
            var_string = '*'.join(vars_tuple) 
            return (-degree, var_string)

        terms_to_sort.sort(key=sort_key)

        # Construct the final output strings
        for vars_tuple, coeff in terms_to_sort:
            if not vars_tuple: # Constant term (degree 0)
                output.append(str(coeff))
            else: # Variable term
                var_str = '*'.join(vars_tuple)
                if coeff == 1:
                    output.append(var_str)
                elif coeff == -1:
                    output.append(f"-{var_str}")
                else:
                    output.append(f"{coeff}*{var_str}")

        return output