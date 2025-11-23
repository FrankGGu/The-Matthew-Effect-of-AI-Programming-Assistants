import heapq
from collections import Counter

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        task_counts = Counter(tasks)
        max_heap = [-count for count in task_counts.values()]
        heapq.heapify(max_heap)

        time = 0
        queue = []

        while max_heap or queue:
            time += 1

            if max_heap:
                count = heapq.heappop(max_heap)
                count += 1
                if count != 0:
                    queue.append((count, time + n))

            if queue and queue[0][1] == time:
                heapq.heappush(max_heap, queue.pop(0)[0])

        return time