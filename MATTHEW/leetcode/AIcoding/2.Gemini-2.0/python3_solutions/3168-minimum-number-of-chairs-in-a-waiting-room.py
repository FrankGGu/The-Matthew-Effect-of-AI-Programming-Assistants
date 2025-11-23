class Solution:
    def minMeetingRooms(self, intervals: List[List[int]]) -> int:
        starts = sorted([i[0] for i in intervals])
        ends = sorted([i[1] for i in intervals])

        start_ptr = 0
        end_ptr = 0

        rooms = 0
        max_rooms = 0

        while start_ptr < len(intervals):
            if starts[start_ptr] < ends[end_ptr]:
                rooms += 1
                start_ptr += 1
            else:
                rooms -= 1
                end_ptr += 1
            max_rooms = max(max_rooms, rooms)

        return max_rooms