import heapq

class Solution:
    def halveArray(self, nums: list[int]) -> int:
        total_sum = sum(nums)
        half_sum = total_sum / 2
        pq = [-num for num in nums]
        heapq.heapify(pq)

        operations = 0
        current_sum = total_sum

        while current_sum > half_sum:
            largest = -heapq.heappop(pq)
            reduction = largest / 2
            current_sum -= reduction
            heapq.heappush(pq, -reduction)
            operations += 1

        return operations