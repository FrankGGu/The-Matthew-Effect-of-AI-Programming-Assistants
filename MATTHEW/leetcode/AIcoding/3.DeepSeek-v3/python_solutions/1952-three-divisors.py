class Solution:
    def isThree(self, n: int) -> bool:
        if n == 1:
            return False
        count = 2  # 1 and n are always divisors
        for i in range(2, int(n ** 0.5) + 1):
            if n % i == 0:
                if i * i == n:
                    count += 1
                else:
                    count += 2
                if count > 3:
                    return False
        return count == 3