import heapq

class Solution:
    def scheduleCourse(self, courses: List[List[int]]) -> int:
        courses.sort(key=lambda x: x[1])
        max_heap = []
        total_time = 0

        for duration, end in courses:
            if total_time + duration <= end:
                heapq.heappush(max_heap, -duration)
                total_time += duration
            elif max_heap and -max_heap[0] > duration:
                total_time += duration + heapq.heappop(max_heap)
                heapq.heappush(max_heap, -duration)

        return len(max_heap)