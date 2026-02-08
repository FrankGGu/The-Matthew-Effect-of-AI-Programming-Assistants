class Solution:
    def isValidWord(self, word: str) -> bool:
        balance = 0
        for char in word:
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            if balance < 0:
                return False
        return balance == 0