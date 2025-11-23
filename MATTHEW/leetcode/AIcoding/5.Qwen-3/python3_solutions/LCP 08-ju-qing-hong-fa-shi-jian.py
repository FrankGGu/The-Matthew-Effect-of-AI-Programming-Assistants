class Solution:
    def findTriggerTime(self, events: List[List[int]], time: int) -> List[int]:
        from collections import defaultdict

        def get_time_count(events, time):
            count = 0
            for e in events:
                if e[0] <= time and e[1] >= time:
                    count += 1
            return count

        result = []
        for i in range(len(events)):
            current = events[i]
            if current[0] <= time and current[1] >= time:
                result.append(get_time_count(events, time))
            else:
                result.append(0)
        return result