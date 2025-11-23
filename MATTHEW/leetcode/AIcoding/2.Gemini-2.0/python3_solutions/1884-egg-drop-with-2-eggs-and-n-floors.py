class Solution:
    def twoEggDrop(self, n: int) -> int:
        k = 0
        while n > 0:
            k += 1
            n -= k
        return k