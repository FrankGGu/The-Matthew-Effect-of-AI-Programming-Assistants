from typing import List
import heapq

class Solution:
    def maxScore(self, nums1: List[int], nums2: List[int], k: int) -> int:
        sorted_pairs = sorted(zip(nums1, nums2), key=lambda x: -x[1])
        min_heap = []
        sum_nums1 = 0
        max_score = 0

        for i in range(len(sorted_pairs)):
            num1, num2 = sorted_pairs[i]
            heapq.heappush(min_heap, num1)
            sum_nums1 += num1

            if len(min_heap) > k:
                sum_nums1 -= heapq.heappop(min_heap)

            if len(min_heap) == k:
                max_score = max(max_score, sum_nums1 * num2)

        return max_score