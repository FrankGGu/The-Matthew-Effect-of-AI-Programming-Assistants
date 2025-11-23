import heapq
from collections import defaultdict

class Solution:
    def mostFrequentIDs(self, nums: List[int], freq: List[int]) -> List[int]:
        count = defaultdict(int)
        max_heap = []
        res = []

        for i in range(len(nums)):
            id_ = nums[i]
            delta = freq[i]
            count[id_] += delta

            if delta > 0:
                heapq.heappush(max_heap, (-count[id_], id_))
            else:
                heapq.heappush(max_heap, (-count[id_], id_))

            while max_heap:
                current_count, current_id = max_heap[0]
                current_count = -current_count
                if current_count == count[current_id]:
                    res.append(current_count)
                    break
                else:
                    heapq.heappop(max_heap)
            else:
                res.append(0)

        return res