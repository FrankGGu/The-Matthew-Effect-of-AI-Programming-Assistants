import heapq

class Solution:
    def kSum(self, nums: List[int], k: int) -> int:
        max_sum = sum(num for num in nums if num > 0)
        abs_nums = sorted(abs(num) for num in nums)
        heap = [(-max_sum, 0)]
        for _ in range(k - 1):
            current_sum, i = heapq.heappop(heap)
            if i < len(abs_nums):
                heapq.heappush(heap, (current_sum + abs_nums[i], i + 1))
                if i > 0:
                    heapq.heappush(heap, (current_sum + abs_nums[i] - abs_nums[i - 1], i + 1))
        return -heap[0][0]