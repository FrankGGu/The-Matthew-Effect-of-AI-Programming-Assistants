import math

class Solution:
    def countDistinctNumbers(self, n: int) -> int:
        if n == 1:
            return 1

        count = 0
        for i in range(1, int(math.sqrt(n)) + 1):
            if n % i == 0:
                count += 1
                if i * i != n:
                    count += 1

        return count