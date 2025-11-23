import heapq

class Solution:
    def getOrder(self, tasks: List[List[int]]) -> List[int]:
        tasks = [(start, duration, idx) for idx, (start, duration) in enumerate(tasks)]
        tasks.sort()
        heap = []
        res = []
        current_time = 0
        i = 0
        n = len(tasks)

        while i < n or heap:
            if not heap and current_time < tasks[i][0]:
                current_time = tasks[i][0]

            while i < n and tasks[i][0] <= current_time:
                start, duration, idx = tasks[i]
                heapq.heappush(heap, (duration, idx))
                i += 1

            duration, idx = heapq.heappop(heap)
            current_time += duration
            res.append(idx)

        return res