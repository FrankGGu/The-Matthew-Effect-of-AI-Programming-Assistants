class Solution:
    def isThree(self, n: int) -> bool:
        if n < 4:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                if i * i == n:
                    return False
                if n // i != i:
                    return False
        return True