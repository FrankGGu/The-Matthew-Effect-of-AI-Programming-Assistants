class Solution:
    def findMaximumElegance(self, items: List[List[int]], k: int) -> int:
        items.sort(key=lambda x: -x[0])
        max_elegance = 0
        current_elegance = 0
        unique_count = 0
        min_heap = []

        for value, index in items:
            if len(min_heap) < k:
                heapq.heappush(min_heap, value)
                current_elegance += value
                if index not in {item[1] for item in items if item[1] in min_heap}:
                    unique_count += 1
            else:
                if value > min_heap[0]:
                    current_elegance += value - min_heap[0]
                    heapq.heappop(min_heap)
                    heapq.heappush(min_heap, value)

            if len(min_heap) == k:
                max_elegance = max(max_elegance, current_elegance + unique_count)

        return max_elegance