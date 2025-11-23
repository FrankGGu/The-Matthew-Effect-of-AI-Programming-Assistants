import heapq

class Solution:
    def getOrder(self, tasks: list[list[int]]) -> list[int]:
        n = len(tasks)
        available_tasks = []
        for i in range(n):
            available_tasks.append([tasks[i][0], tasks[i][1], i])
        available_tasks.sort()

        result = []
        pq = []
        i = 0
        time = 0

        while len(result) < n:
            while i < n and available_tasks[i][0] <= time:
                heapq.heappush(pq, (available_tasks[i][1], available_tasks[i][2]))
                i += 1

            if pq:
                processing_time, index = heapq.heappop(pq)
                time += processing_time
                result.append(index)
            elif i < n:
                time = available_tasks[i][0]
            else:
                break

        return result