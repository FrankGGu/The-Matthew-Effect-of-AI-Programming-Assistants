import heapq

class Solution:
    def minimumDifference(self, nums: list[int]) -> int:
        n = len(nums) // 3

        # Calculate left_min_sums:
        # left_min_sums[k] stores the minimum sum of n elements chosen from nums[0...k-1].
        # The index k represents the number of elements considered for the left part.
        # k ranges from n to 2n.
        pq_left = []  # Max-heap (stores negative values to simulate max-heap for smallest elements)
        current_sum_left = 0
        left_min_sums = [float('inf')] * (2 * n + 1)

        for i in range(2 * n):
            val = nums[i]
            if len(pq_left) < n:
                heapq.heappush(pq_left, -val)
                current_sum_left += val
            elif val < -pq_left[0]:  # If current element is smaller than the largest in the heap
                current_sum_left -= (-heapq.heappop(pq_left))  # Remove largest from heap (smallest negative)
                heapq.heappush(pq_left, -val)
                current_sum_left += val

            # Store the current min sum of n elements if the heap is full
            if len(pq_left) == n:
                left_min_sums[i + 1] = current_sum_left

        # Calculate right_max_sums:
        # right_max_sums[k] stores the maximum sum of n elements chosen from nums[k...3n-1].
        # The index k represents the starting index for the right part.
        # k ranges from n to 2n.
        pq_right = []  # Min-heap
        current_sum_right = 0
        right_max_sums = [float('-inf')] * (3 * n) # Array of size 3n, indices 0 to 3n-1

        # Iterate from right to left, from index 3n-1 down to n
        for i in range(3 * n - 1, n - 1, -1):
            val = nums[i]
            if len(pq_right) < n:
                heapq.heappush(pq_right, val)
                current_sum_right += val
            elif val > pq_right[0]:  # If current element is larger than the smallest in the heap
                current_sum_right -= heapq.heappop(pq_right)  # Remove smallest from heap
                heapq.heappush(pq_right, val)
                current_sum_right += val

            # Store the current max sum of n elements if the heap is full
            if len(pq_right) == n:
                right_max_sums[i] = current_sum_right

        # Calculate minimum difference
        # Iterate through all possible split points 'i'
        # 'i' represents the boundary: sum1 elements from nums[0...i-1], sum2 elements from nums[i...3n-1]
        # The valid range for 'i' is from n to 2n.
        min_diff = float('inf')
        for i in range(n, 2 * n + 1):
            # left_min_sums[i] is the minimum sum of n elements from nums[0...i-1]
            # right_max_sums[i] is the maximum sum of n elements from nums[i...3n-1]
            # Both values will always be valid (not inf/-inf) within this loop range
            min_diff = min(min_diff, left_min_sums[i] - right_max_sums[i])

        return min_diff