class Solution:
    def addRungs(self, rungs: List[int], dist: int) -> int:
        count = 0
        current_height = 0

        for rung in rungs:
            if rung - current_height > dist:
                count += (rung - current_height - 1) // dist
            current_height = rung

        return count