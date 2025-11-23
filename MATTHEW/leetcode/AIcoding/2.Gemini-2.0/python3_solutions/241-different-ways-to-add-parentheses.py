class Solution:
    def diffWaysToCompute(self, expression: str) -> list[int]:
        if expression.isdigit():
            return [int(expression)]

        result = []
        for i, char in enumerate(expression):
            if char in ['+', '-', '*']:
                left = self.diffWaysToCompute(expression[:i])
                right = self.diffWaysToCompute(expression[i+1:])

                for l in left:
                    for r in right:
                        if char == '+':
                            result.append(l + r)
                        elif char == '-':
                            result.append(l - r)
                        else:
                            result.append(l * r)
        return result