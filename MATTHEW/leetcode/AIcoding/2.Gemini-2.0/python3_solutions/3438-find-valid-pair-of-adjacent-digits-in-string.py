class Solution:
    def isValid(self, num: str) -> bool:
        n = len(num)
        for i in range(n - 1):
            a = int(num[i])
            b = int(num[i+1])
            if (a + b) % 2 == 0 and a != b:
                return True
        return False