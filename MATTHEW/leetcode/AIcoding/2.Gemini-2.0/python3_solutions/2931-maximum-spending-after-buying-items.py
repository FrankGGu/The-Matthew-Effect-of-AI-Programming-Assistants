class Solution:
    def maximumSpending(self, costs: List[List[int]]) -> int:
        m = len(costs)
        n = len(costs[0])

        heap = []
        for i in range(m):
            heapq.heappush(heap, (-costs[i][-1], i, n - 1))

        ans = 0
        count = 0

        while heap:
            cost, row, col = heapq.heappop(heap)
            ans += -cost
            count += 1

            if col > 0:
                heapq.heappush(heap, (-costs[row][col - 1], row, col - 1))

        return ans