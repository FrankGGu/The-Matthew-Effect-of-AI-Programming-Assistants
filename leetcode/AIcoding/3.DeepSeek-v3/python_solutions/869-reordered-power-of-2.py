class Solution:
    def reorderedPowerOf2(self, n: int) -> bool:
        count = collections.Counter(str(n))
        for i in range(30):
            power = str(1 << i)
            if collections.Counter(power) == count:
                return True
        return False