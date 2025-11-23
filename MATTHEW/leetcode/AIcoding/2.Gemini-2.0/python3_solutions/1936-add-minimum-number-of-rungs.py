class Solution:
    def addRungs(self, rungs: list[int], dist: int) -> int:
        count = 0
        prev = 0
        for rung in rungs:
            diff = rung - prev
            if diff > dist:
                count += (diff - 1) // dist
            prev = rung
        return count