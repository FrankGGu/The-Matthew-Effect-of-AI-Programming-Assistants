class Solution:
    def maxFreeTime(self, schedule: List[List[int]]) -> List[int]:
        events = []
        for s in schedule:
            events.append((s[0], 1))
            events.append((s[1], -1))

        events.sort()

        free_time = []
        count = 0
        last_time = -1

        for time, change in events:
            if count == 0 and last_time != -1:
                free_time.append([last_time, time])
            count += change
            last_time = time

        return free_time