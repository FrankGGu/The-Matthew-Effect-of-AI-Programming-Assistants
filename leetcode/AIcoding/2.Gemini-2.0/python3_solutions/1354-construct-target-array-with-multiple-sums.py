import heapq

class Solution:
    def isPossible(self, target: List[int]) -> bool:
        total_sum = sum(target)
        heap = [-num for num in target]
        heapq.heapify(heap)

        while True:
            largest = -heapq.heappop(heap)

            if largest == 1:
                return True

            rest_sum = total_sum - largest
            if largest <= rest_sum or rest_sum == 0:
                return False

            prev = largest % rest_sum
            if prev == 0:
                prev = rest_sum

            heapq.heappush(heap, -prev)
            total_sum = rest_sum + prev