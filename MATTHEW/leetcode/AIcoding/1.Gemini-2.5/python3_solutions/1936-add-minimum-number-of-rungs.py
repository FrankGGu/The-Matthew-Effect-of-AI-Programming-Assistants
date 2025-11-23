class Solution:
    def addRungs(self, rungs: list[int], dist: int) -> int:
        added_rungs = 0
        current_height = 0
        for rung_height in rungs:
            gap = rung_height - current_height
            if gap > dist:
                added_rungs += (gap - 1) // dist
            current_height = rung_height
        return added_rungs