import collections

class Solution:
    def reorderedPowerOf2(self, n: int) -> bool:
        count = collections.Counter(str(n))
        for i in range(30):
            power = 1 << i
            if count == collections.Counter(str(power)):
                return True
        return False