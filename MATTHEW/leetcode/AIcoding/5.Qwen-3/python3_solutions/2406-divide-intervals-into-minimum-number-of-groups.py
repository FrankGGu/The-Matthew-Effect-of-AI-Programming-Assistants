class Solution:
    def mergeGroups(self, intervals: List[List[int]]) -> int:
        intervals.sort()
        groups = []
        for start, end in intervals:
            placed = False
            for i in range(len(groups)):
                if groups[i][1] < start:
                    groups[i] = [start, end]
                    placed = True
                    break
            if not placed:
                groups.append([start, end])
        return len(groups)