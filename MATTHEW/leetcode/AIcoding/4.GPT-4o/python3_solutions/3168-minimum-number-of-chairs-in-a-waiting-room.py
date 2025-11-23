class Solution:
    def minimumNumberOfChairs(self, A: List[List[int]]) -> int:
        events = []
        for start, end in A:
            events.append((start, 1))
            events.append((end + 1, -1))

        events.sort()
        max_chairs = 0
        current_chairs = 0

        for _, change in events:
            current_chairs += change
            max_chairs = max(max_chairs, current_chairs)

        return max_chairs