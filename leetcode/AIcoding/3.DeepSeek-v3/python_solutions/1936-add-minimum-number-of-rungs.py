class Solution:
    def addRungs(self, rungs: List[int], dist: int) -> int:
        res = 0
        prev = 0
        for rung in rungs:
            diff = rung - prev
            if diff > dist:
                res += (diff - 1) // dist
            prev = rung
        return res