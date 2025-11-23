import heapq

class Solution:
    def minimumDeviation(self, nums: list[int]) -> int:
        max_pq = []
        current_min = float('inf')

        for num in nums:
            # If the number is odd, multiply by 2 to make it even.
            # This is the only operation that can increase an odd number.
            # All numbers in the heap will be even initially.
            if num % 2 == 1:
                num *= 2

            # Use a max-heap (by storing negative values in Python's min-heap)
            # to easily get the largest element.
            heapq.heappush(max_pq, -num)

            # Keep track of the minimum value currently in our set.
            current_min = min(current_min, num)

        min_deviation = float('inf')

        # The loop continues as long as the maximum element is even.
        # If the maximum element becomes odd, it cannot be divided further,
        # so we cannot reduce the deviation by operating on it.
        while True:
            # Get the current maximum element from the heap.
            max_val = -heapq.heappop(max_pq)

            # Update the minimum deviation found so far.
            min_deviation = min(min_deviation, max_val - current_min)

            # If the maximum value is odd, we cannot divide it further.
            # This means we've explored all possible reductions for this path.
            if max_val % 2 == 1:
                break

            # If max_val is even, divide it by 2.
            new_val = max_val // 2

            # Update current_min with the new (potentially smaller) value.
            current_min = min(current_min, new_val)

            # Add the new value back to the heap.
            heapq.heappush(max_pq, -new_val)

        return min_deviation