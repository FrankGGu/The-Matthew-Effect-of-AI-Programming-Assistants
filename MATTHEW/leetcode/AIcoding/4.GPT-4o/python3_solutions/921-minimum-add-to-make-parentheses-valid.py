class Solution:
    def minAddToMakeValid(self, s: str) -> int:
        balance = 0
        count = 0
        for char in s:
            if char == '(':
                balance += 1
            elif char == ')':
                if balance == 0:
                    count += 1
                else:
                    balance -= 1
        return balance + count