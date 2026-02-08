import heapq

class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        n = len(nums) // 3

        # Left part: min heap to keep track of the largest n elements in the first 2n elements
        left = []
        left_sum = 0
        for i in range(2 * n):
            heapq.heappush(left, -nums[i])
            left_sum += nums[i]
            if len(left) > n:
                val = -heapq.heappop(left)
                left_sum -= val

        # Right part: max heap to keep track of the smallest n elements in the last 2n elements
        right = []
        right_sum = 0
        for i in range(3 * n - 1, n - 1, -1):
            heapq.heappush(right, nums[i])
            right_sum += nums[i]
            if len(right) > n:
                val = heapq.heappop(right)
                right_sum -= val

        min_diff = left_sum - right_sum

        # Now, slide the partition point from the middle to the left
        left_sums = [0] * (n + 1)
        left_sums[n] = left_sum
        left_heap = left.copy()
        temp_sum = left_sum

        for k in range(n - 1, -1, -1):
            num = nums[2 * n + k]
            if num < -left_heap[0]:
                popped = -heapq.heappop(left_heap)
                temp_sum -= popped
                heapq.heappush(left_heap, -num)
                temp_sum += num
            left_sums[k] = temp_sum

        right_sums = [0] * (n + 1)
        right_sums[0] = right_sum
        right_heap = right.copy()
        temp_sum = right_sum

        for k in range(1, n + 1):
            num = nums[n + k - 1]
            if num > right_heap[0]:
                popped = heapq.heappop(right_heap)
                temp_sum -= popped
                heapq.heappush(right_heap, num)
                temp_sum += num
            right_sums[k] = temp_sum

        for k in range(n + 1):
            current_diff = left_sums[k] - right_sums[k]
            if current_diff < min_diff:
                min_diff = current_diff

        return min_diff