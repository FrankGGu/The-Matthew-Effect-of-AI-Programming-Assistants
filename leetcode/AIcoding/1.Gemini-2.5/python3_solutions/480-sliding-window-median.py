import heapq
from collections import Counter

class Solution:
    def medianSlidingWindow(self, nums: list[int], k: int) -> list[float]:
        max_heap = []  # Stores negative values of the smaller half
        min_heap = []  # Stores values of the larger half
        removed_elements = Counter()
        result = []

        def _clean_top(heap, is_max_heap):
            # Remove elements from the top of the heap if they are marked for removal
            while heap:
                val_in_heap = -heap[0] if is_max_heap else heap[0]
                if removed_elements[val_in_heap] > 0:
                    removed_elements[val_in_heap] -= 1
                    heapq.heappop(heap)
                else:
                    break

        def _balance_heaps():
            # Ensure heaps contain only valid elements at their tops
            _clean_top(max_heap, True)
            _clean_top(min_heap, False)

            # Balance sizes: max_heap should have len(min_heap) or len(min_heap) + 1 elements
            # Move elements from min_heap to max_heap if max_heap is too small
            while len(max_heap) < len(min_heap):
                heapq.heappush(max_heap, -heapq.heappop(min_heap))
                _clean_top(max_heap, True) # Clean new top of max_heap
                _clean_top(min_heap, False) # Clean new top of min_heap (if any)

            # Move elements from max_heap to min_heap if max_heap is too large
            while len(max_heap) > len(min_heap) + 1:
                heapq.heappush(min_heap, -heapq.heappop(max_heap))
                _clean_top(min_heap, False) # Clean new top of min_heap
                _clean_top(max_heap, True) # Clean new top of max_heap (if any)

            # Ensure elements are in correct halves (max_heap.top <= min_heap.top)
            _clean_top(max_heap, True)
            _clean_top(min_heap, False)
            if max_heap and min_heap and -max_heap[0] > min_heap[0]:
                val_from_max = heapq.heappop(max_heap)
                val_from_min = heapq.heappop(min_heap)
                heapq.heappush(max_heap, -val_from_min)
                heapq.heappush(min_heap, -val_from_max)
                # No need to clean after this swap, as they were already cleaned before comparison
                # and the new tops are just swapped versions of the old tops.

        for i in range(len(nums)):
            num = nums[i]

            # Add current number to one of the heaps
            if not max_heap or num <= -max_heap[0]:
                heapq.heappush(max_heap, -num)
            else:
                heapq.heappush(min_heap, num)

            _balance_heaps() # Balance after adding

            if i >= k - 1: # Window is full
                # Calculate median
                _balance_heaps() # Final balance before calculating median
                if k % 2 == 1:
                    median = float(-max_heap[0])
                else:
                    median = (-max_heap[0] + min_heap[0]) / 2.0
                result.append(median)

                # Mark the element leaving the window for removal
                old_num = nums[i - k + 1]
                removed_elements[old_num] += 1
                _balance_heaps() # Balance after marking for removal

        return result