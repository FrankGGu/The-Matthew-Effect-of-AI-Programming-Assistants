class Solution:
    def getOrder(self, tasks: List[List[int]]) -> List[int]:
        n = len(tasks)
        indexed_tasks = [(tasks[i][0], tasks[i][1], i) for i in range(n)]
        indexed_tasks.sort()

        result = []
        min_heap = []
        current_time = 0
        i = 0

        while i < n or min_heap:
            while i < n and indexed_tasks[i][0] <= current_time:
                heapq.heappush(min_heap, (indexed_tasks[i][1], indexed_tasks[i][2]))
                i += 1

            if min_heap:
                processing_time, index = heapq.heappop(min_heap)
                result.append(index)
                current_time += processing_time
            else:
                current_time = indexed_tasks[i][0]

        return result