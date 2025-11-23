class Solution:
    def countCoveredBuildings(self, ranges: list[list[int]]) -> int:
        ranges.sort()
        covered = set()
        for start, end in ranges:
            for i in range(start, end + 1):
                covered.add(i)
        return len(covered)