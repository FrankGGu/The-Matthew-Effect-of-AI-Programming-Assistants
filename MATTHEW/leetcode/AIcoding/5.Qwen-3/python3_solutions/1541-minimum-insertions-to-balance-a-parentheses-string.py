class Solution:
    def minInsertions(self, s: str) -> int:
        res = 0
        balance = 0
        for c in s:
            if c == '(':
                balance += 1
                if balance % 2 == 0:
                    res += 1
            else:
                balance -= 1
                if balance < 0:
                    res += 1
                    balance += 2
        return res + balance