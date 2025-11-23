class Solution:
    def minAddToMakeValid(self, s: str) -> int:
        balance = 0
        count = 0
        for char in s:
            if char == '(':
                balance += 1
            elif balance > 0:
                balance -= 1
            else:
                count += 1
        return count + balance