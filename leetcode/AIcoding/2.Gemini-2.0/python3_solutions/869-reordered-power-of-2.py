from collections import Counter

class Solution:
    def reorderedPowerOf2(self, n: int) -> bool:
        count = Counter(str(n))
        for i in range(60):
            power_of_2 = str(1 << i)
            if Counter(power_of_2) == count:
                return True
        return False