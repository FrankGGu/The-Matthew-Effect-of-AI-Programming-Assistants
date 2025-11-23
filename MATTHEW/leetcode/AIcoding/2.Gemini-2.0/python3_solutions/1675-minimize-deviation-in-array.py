import heapq

class Solution:
    def minimumDeviation(self, nums: list[int]) -> int:
        s = set()
        for num in nums:
            if num % 2 == 0:
                s.add(num)
            else:
                s.add(num * 2)

        min_heap = [-x for x in s]
        heapq.heapify(min_heap)

        min_val = min(s)
        ans = float('inf')

        while True:
            max_val = -heapq.heappop(min_heap)
            ans = min(ans, max_val - min_val)

            if max_val % 2 == 0:
                min_val = min(min_val, max_val // 2)
                heapq.heappush(min_heap, - (max_val // 2))
            else:
                break

        return ans