import heapq

class Solution:
    def makeArrayNonDecreasing(self, nums: list[int]) -> int:
        cost = 0
        pq = []

        for num in nums:
            while pq and num < pq[0]:
                cost += pq[0] - num
                heapq.heappop(pq)
                heapq.heappush(pq, num)

            heapq.heappush(pq, num)

        return cost