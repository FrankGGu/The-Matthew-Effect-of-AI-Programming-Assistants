import heapq

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        operations = 0
        # Use a min-heap to simulate a max-heap by storing negative values.
        # This heap will store elements that form a non-decreasing sequence.
        # The top of the heap (smallest negative value) corresponds to the largest element in the sequence.
        max_heap = [] 

        for num in nums:
            # Always add the current number to the heap.
            # We push -num because heapq is a min-heap, and we want to retrieve the maximum value.
            heapq.heappush(max_heap, -num)

            # If the current number `num` is smaller than the largest element currently in our non-decreasing sequence
            # (which is `-max_heap[0]` because `max_heap[0]` is the smallest negative, meaning its absolute value is largest),
            # we must increment `num` to match `-max_heap[0]`.
            if -max_heap[0] > num:
                # Calculate the operations needed to increment `num` to `-max_heap[0]`.
                operations += (-max_heap[0] - num)

                # Remove the element that was too large from the heap.
                # This element is effectively replaced by `num` (which is now incremented to `-max_heap[0]`).
                heapq.heappop(max_heap)

                # Add `num` (as a negative value) back to the heap.
                # This ensures that the element at this position in the non-decreasing sequence is now `num`
                # (which has been effectively increased to `-max_heap[0]`).
                heapq.heappush(max_heap, -num)

        return operations