import heapq

class Solution:
    def minOperations(self, nums: list[int], k: int) -> int:
        heapq.heapify(nums)

        operations = 0

        while len(nums) >= 2 and nums[0] < k:
            x = heapq.heappop(nums)
            y = heapq.heappop(nums)

            new_val = 2 * x + y
            heapq.heappush(nums, new_val)
            operations += 1

        return operations