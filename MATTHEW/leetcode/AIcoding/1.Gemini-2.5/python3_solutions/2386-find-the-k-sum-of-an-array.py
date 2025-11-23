import heapq

class Solution:
    def kSum(self, nums: list[int], k: int) -> int:
        max_sum_positive = 0

        # Create an array of absolute values for all numbers.
        # Also, calculate the sum of all positive numbers in the original array.
        # This `max_sum_positive` will be our base for calculating the k-sums.
        arr = []
        for x in nums:
            if x >= 0:
                max_sum_positive += x
            arr.append(abs(x))

        # Sort the absolute values array in ascending order.
        # This `arr` now represents the "costs" to deviate from `max_sum_positive`.
        arr.sort()

        # The problem asks for the k-th smallest subsequence sum.
        # Let S_sub be a sum of a subsequence of `nums`.
        # S_sub can be expressed as `max_sum_positive - (sum of a subset of arr)`.
        # To get the k-th smallest S_sub, we need `max_sum_positive - (k-th largest sum of a subset of arr)`.
        # The k-th largest sum of a subset of arr is `sum(arr) - (k-th smallest sum of a subset of arr)`.
        # So, the answer is `max_sum_positive - (sum(arr) - (k-th smallest sum of a subset of arr))`.
        # This simplifies to `max_sum_positive - sum(arr) + (k-th smallest sum of a subset of arr)`.

        # We need to find the k-th smallest sum of a subset of `arr`.
        # We use a min-heap to generate these subset sums efficiently.
        # The heap stores tuples `(current_subset_sum, index_of_last_element_added)`.
        # `index_of_last_element_added` is used to ensure we only consider elements in increasing order of index
        # and to avoid generating duplicate subset sums.

        # Initialize the min-heap with (0, -1).
        # 0 is the sum of an empty subset. -1 indicates no element has been added yet.
        pq = [(0, -1)] 

        # This list will store the k smallest subset sums of `arr` in increasing order.
        k_smallest_subset_sums = []

        while pq and len(k_smallest_subset_sums) < k:
            current_subset_sum, last_added_idx = heapq.heappop(pq)
            k_smallest_subset_sums.append(current_subset_sum)

            # Option 1: Extend the current subset by including the next available element `arr[last_added_idx + 1]`.
            # This is valid if there's a next element to add.
            if last_added_idx + 1 < len(arr):
                next_idx = last_added_idx + 1
                heapq.heappush(pq, (current_subset_sum + arr[next_idx], next_idx))

            # Option 2: Generate a new subset sum by replacing the last added element `arr[last_added_idx]`
            # with the next available element `arr[last_added_idx + 1]`.
            # This is crucial for exploring sums efficiently without duplicates.
            # This is valid only if an element was actually added (`last_added_idx >= 0`)
            # and there is a next element to replace it with (`last_added_idx + 1 < len(arr)`).
            if last_added_idx >= 0 and last_added_idx + 1 < len(arr):
                next_idx = last_added_idx + 1
                heapq.heappush(pq, (current_subset_sum - arr[last_added_idx] + arr[next_idx], next_idx))

        # The k-th smallest sum of a subset of `arr` is `k_smallest_subset_sums[k-1]`.
        s_k_subset = k_smallest_subset_sums[k-1]

        # Calculate the total sum of all absolute values in `arr`.
        total_abs_sum = sum(arr)

        # Apply the derived formula to get the final answer.
        return max_sum_positive - total_abs_sum + s_k_subset