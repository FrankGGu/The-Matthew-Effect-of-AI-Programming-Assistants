class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        from collections import Counter
        import heapq

        count = Counter(tasks)
        max_heap = [-cnt for cnt in count.values()]
        heapq.heapify(max_heap)

        time = 0
        while max_heap:
            i = 0
            while i <= n and max_heap:
                if -max_heap[0] > 1:
                    heapq.heappush(max_heap, -(-heapq.heappop(max_heap) - 1))
                else:
                    heapq.heappop(max_heap)
                i += 1
                time += 1
        return time