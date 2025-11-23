import heapq

class Solution:
    def minimumDifference(self, nums: list[int]) -> int:
        n = len(nums) // 3

        left = nums[:2 * n]
        right = nums[n:]

        left_sums = [0] * (2 * n + 1)
        left_sums[0] = 0

        heap = []
        current_sum = 0
        for i in range(n):
            heapq.heappush(heap, left[i])
            current_sum += left[i]
        left_sums[n] = current_sum

        for i in range(n, 2 * n):
            if left[i] > heap[0]:
                current_sum -= heapq.heappop(heap)
                current_sum += left[i]
                heapq.heappush(heap, left[i])
            left_sums[i + 1] = current_sum

        right_sums = [0] * (2 * n + 1)
        right_sums[0] = 0

        heap = []
        current_sum = 0
        for i in range(2 * n - 1, n - 1, -1):
            heapq.heappush(heap, -right[i - n])
            current_sum += right[i - n]
        right_sums[n] = current_sum

        for i in range(n - 1, -1, -1):
            if right[i - n] < -heap[0]:
                current_sum -= -heapq.heappop(heap)
                current_sum += right[i - n]
                heapq.heappush(heap, -right[i - n])
            right_sums[2 * n - i] = current_sum

        min_diff = float('inf')
        for i in range(n, 2 * n + 1):
            min_diff = min(min_diff, left_sums[i] - right_sums[2 * n - i])

        return min_diff