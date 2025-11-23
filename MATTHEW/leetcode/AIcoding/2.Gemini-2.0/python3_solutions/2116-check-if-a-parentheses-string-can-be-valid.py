class Solution:
    def checkValidString(self, s: str, locked: str) -> bool:
        low = 0
        high = 0
        for i in range(len(s)):
            if locked[i] == '1':
                if s[i] == '(':
                    low += 1
                    high += 1
                else:
                    low -= 1
                    high -= 1
            else:
                low -= 1
                high += 1

            low = max(low, 0)
            if high < 0:
                return False

        return low == 0