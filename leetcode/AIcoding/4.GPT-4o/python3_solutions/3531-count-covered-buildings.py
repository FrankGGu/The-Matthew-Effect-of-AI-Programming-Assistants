class Solution:
    def countCoveredBuildings(self, buildings: List[List[int]]) -> int:
        events = []
        for start, end in buildings:
            events.append((start, 1))
            events.append((end, -1))

        events.sort()

        count = 0
        current_coverage = 0
        last_position = None

        for position, event in events:
            if current_coverage > 0 and last_position is not None:
                count += position - last_position

            current_coverage += event
            last_position = position

        return count