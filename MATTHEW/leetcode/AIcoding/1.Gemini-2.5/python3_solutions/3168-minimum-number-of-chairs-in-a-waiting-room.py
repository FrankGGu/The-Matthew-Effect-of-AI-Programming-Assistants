from typing import List

class Solution:
    def minimumChairs(self, times: List[List[int]]) -> int:
        events = []
        for arrival, departure in times:
            events.append((arrival, 1))
            events.append((departure, -1))

        events.sort()

        current_chairs = 0
        max_chairs = 0

        for _, change_type in events:
            current_chairs += change_type
            max_chairs = max(max_chairs, current_chairs)

        return max_chairs