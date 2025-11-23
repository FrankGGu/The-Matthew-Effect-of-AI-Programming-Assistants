class Solution:
    def removeOuterParentheses(self, s: str) -> str:
        result = []
        balance = 0
        for char in s:
            if char == '(':
                balance += 1
            else:
                balance -= 1
            if balance == 0:
                continue
            result.append(char)
        return ''.join(result)