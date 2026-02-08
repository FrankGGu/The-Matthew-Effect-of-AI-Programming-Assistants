import heapq

class Solution:
    def fillCups(self, cups: list[int]) -> int:
        cups.sort()
        a, b, c = cups[0], cups[1], cups[2]

        if c > a + b:
            return c
        else:
            return (a + b + c + 1) // 2