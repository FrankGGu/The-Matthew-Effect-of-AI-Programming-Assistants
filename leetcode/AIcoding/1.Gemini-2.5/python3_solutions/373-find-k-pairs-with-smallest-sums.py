import heapq

class Solution:
    def kSmallestPairs(self, nums1: list[int], nums2: list[int], k: int) -> list[list[int]]:
        if not nums1 or not nums2 or k == 0:
            return []

        min_heap = []
        result = []

        # Initialize the min-heap with pairs (nums1[i], nums2[0])
        # for i from 0 up to min(len(nums1), k) - 1.
        # We only need to consider at most k elements from nums1 initially
        # because we are looking for k pairs, and the smallest sums will come
        # from smaller elements in nums1.
        for i in range(min(len(nums1), k)):
            # Store (sum, index_in_nums1, index_in_nums2)
            heapq.heappush(min_heap, (nums1[i] + nums2[0], i, 0))

        # Extract k smallest pairs
        while min_heap and len(result) < k:
            current_sum, i, j = heapq.heappop(min_heap)
            result.append([nums1[i], nums2[j]])

            # If there's a next element in nums2 for the current nums1[i],
            # push that new pair (nums1[i], nums2[j+1]) into the heap.
            # This ensures we explore all possible pairs systematically.
            if j + 1 < len(nums2):
                heapq.heappush(min_heap, (nums1[i] + nums2[j+1], i, j + 1))

        return result