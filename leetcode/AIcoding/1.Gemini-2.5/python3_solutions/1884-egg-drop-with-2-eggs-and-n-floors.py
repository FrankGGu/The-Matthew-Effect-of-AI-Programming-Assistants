class Solution:
    def twoEggDrop(self, n: int) -> int:
        k = 0
        floors_covered = 0
        while floors_covered < n:
            k += 1
            floors_covered += k
        return k