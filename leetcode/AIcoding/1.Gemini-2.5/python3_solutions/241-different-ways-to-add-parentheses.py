import functools

class Solution:
    def diffWaysToCompute(self, expression: str) -> list[int]:

        @functools.lru_cache(None)
        def solve(s: str) -> list[int]:
            results = []
            is_number = True

            for i, char in enumerate(s):
                if char in "+-*":
                    is_number = False

                    left_parts = solve(s[:i])
                    right_parts = solve(s[i+1:])

                    for l_val in left_parts:
                        for r_val in right_parts:
                            if char == '+':
                                results.append(l_val + r_val)
                            elif char == '-':
                                results.append(l_val - r_val)
                            else: # char == '*'
                                results.append(l_val * r_val)

            if is_number:
                results.append(int(s))

            return results

        return solve(expression)