import heapq

class Solution:
    def maxKelements(self, nums: List[int], k: int) -> int:
        nums = [-x for x in nums]
        heapq.heapify(nums)

        total_score = 0
        for _ in range(k):
            max_val = -heapq.heappop(nums)
            total_score += max_val
            heapq.heappush(nums, -math.ceil(max_val / 3))

        return total_score