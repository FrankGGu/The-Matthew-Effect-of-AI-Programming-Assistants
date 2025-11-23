class Solution:
    def isFascinating(self, n: int) -> bool:
        if n < 100 or n > 999:
            return False
        concatenated = str(n) + str(n * 2) + str(n * 3)
        return len(set(concatenated)) == 9 and '0' not in concatenated