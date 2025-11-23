import heapq

class Solution:
    def scheduleCourse(self, courses: list[list[int]]) -> int:
        courses.sort(key=lambda x: x[1])

        taken_courses_durations = []
        current_time = 0

        for duration, last_day in courses:
            if current_time + duration <= last_day:
                current_time += duration
                heapq.heappush(taken_courses_durations, -duration)
            elif taken_courses_durations and duration < -taken_courses_durations[0]:
                longest_prev_duration = -heapq.heappop(taken_courses_durations)
                current_time -= longest_prev_duration
                current_time += duration
                heapq.heappush(taken_courses_durations, -duration)

        return len(taken_courses_durations)