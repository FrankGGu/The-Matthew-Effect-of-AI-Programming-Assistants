import heapq

class Solution:
    def halveArray(self, nums: list[int]) -> int:
        total_sum = sum(nums)
        target_sum = total_sum / 2

        # Use a max-heap (by storing negative values in a min-heap)
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        operations = 0
        current_sum = total_sum

        while current_sum > target_sum:
            # Pop the largest element (smallest negative)
            largest_num = -heapq.heappop(max_heap)

            # Halve it
            halved_num = largest_num / 2

            # Update current sum
            current_sum -= (largest_num - halved_num)

            # Push the halved number back
            heapq.heappush(max_heap, -halved_num)

            operations += 1

        return operations