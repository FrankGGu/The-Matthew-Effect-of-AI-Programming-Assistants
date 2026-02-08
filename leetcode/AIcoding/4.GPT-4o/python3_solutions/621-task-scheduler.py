import heapq
from collections import Counter

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        task_counts = Counter(tasks)
        max_heap = [-count for count in task_counts.values()]
        heapq.heapify(max_heap)

        time = 0
        while max_heap:
            wait = []
            for _ in range(n + 1):
                if max_heap:
                    wait.append(heapq.heappop(max_heap))

            for count in wait:
                if count + 1 < 0:
                    heapq.heappush(max_heap, count + 1)

            time += n + 1 if max_heap else len(wait)

        return time