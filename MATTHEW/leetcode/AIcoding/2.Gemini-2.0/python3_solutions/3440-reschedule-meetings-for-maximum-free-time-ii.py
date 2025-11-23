import heapq

class Solution:
    def solve(self, meetings):
        events = []
        for start, end, person in meetings:
            events.append((start, 1, person))
            events.append((end, -1, person))
        events.sort()

        pq = []
        last_time = -1
        ans = 0
        busy_people = set()

        for time, type, person in events:
            if pq and time > last_time:
                ans += time - last_time

            last_time = time

            if type == 1:
                heapq.heappush(pq, person)
                busy_people.add(person)
            else:
                pq.remove(person)
                heapq.heapify(pq)
                busy_people.remove(person)

        return ans

    def totalFreeTime(self, meetings: list[list[list[int]]]) -> int:
        flat_meetings = []
        for person_meetings in meetings:
            for meeting in person_meetings:
                flat_meetings.append((meeting[0], meeting[1], len(flat_meetings)))
        return self.solve(flat_meetings)