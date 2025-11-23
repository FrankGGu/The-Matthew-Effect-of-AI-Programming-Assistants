class Solution:
    def removeOuterParentheses(self, s: str) -> str:
        res = ""
        balance = 0
        for char in s:
            if char == '(':
                if balance > 0:
                    res += char
                balance += 1
            elif char == ')':
                balance -= 1
                if balance > 0:
                    res += char
        return res