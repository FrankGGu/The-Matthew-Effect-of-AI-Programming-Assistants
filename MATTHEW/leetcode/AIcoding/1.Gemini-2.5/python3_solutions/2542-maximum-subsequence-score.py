import heapq

class Solution:
    def maxScore(self, nums1: list[int], nums2: list[int], k: int) -> int:
        pairs = []
        for i in range(len(nums1)):
            pairs.append((nums1[i], nums2[i]))

        pairs.sort(key=lambda x: x[1], reverse=True)

        max_score = 0
        current_sum_n1 = 0
        min_heap = []

        for n1, n2 in pairs:
            current_sum_n1 += n1
            heapq.heappush(min_heap, n1)

            if len(min_heap) > k:
                smallest_n1 = heapq.heappop(min_heap)
                current_sum_n1 -= smallest_n1

            if len(min_heap) == k:
                max_score = max(max_score, current_sum_n1 * n2)

        return max_score