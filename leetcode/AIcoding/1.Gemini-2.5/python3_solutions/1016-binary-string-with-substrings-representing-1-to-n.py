class Solution:
    def queryString(self, s: str, n: int) -> bool:
        for i in range(1, n + 1):
            binary_i = bin(i)[2:]
            if binary_i not in s:
                return False
        return True