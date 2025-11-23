import heapq

class Solution:
    def markElements(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        n = len(nums)

        pq = []
        for i in range(n):
            heapq.heappush(pq, (nums[i], i))

        marked = [False] * n

        current_total_sum = 0
        ans = []

        for idx, k in queries:
            if not marked[idx]:
                current_total_sum += nums[idx]
                marked[idx] = True

            for _ in range(k):
                while pq and marked[pq[0][1]]:
                    heapq.heappop(pq)

                if pq:
                    val, original_i = heapq.heappop(pq)
                    current_total_sum += val
                    marked[original_i] = True
                else:
                    break

            ans.append(current_total_sum)

        return ans