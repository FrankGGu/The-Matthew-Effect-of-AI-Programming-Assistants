class Solution:
    def checkString(self, s: str) -> bool:
        b_found = False
        for char in s:
            if char == 'b':
                b_found = True
            elif b_found:
                return False
        return True