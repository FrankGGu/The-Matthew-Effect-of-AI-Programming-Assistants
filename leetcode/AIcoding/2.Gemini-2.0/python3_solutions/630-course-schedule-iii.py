import heapq

class Solution:
    def scheduleCourse(self, courses: list[list[int]]) -> int:
        courses.sort(key=lambda x: x[1])
        heap = []
        time = 0
        for duration, lastDay in courses:
            if time + duration <= lastDay:
                time += duration
                heapq.heappush(heap, -duration)
            elif heap and duration < -heap[0]:
                time += duration + heapq.heappop(heap)
                heapq.heappush(heap, -duration)
        return len(heap)