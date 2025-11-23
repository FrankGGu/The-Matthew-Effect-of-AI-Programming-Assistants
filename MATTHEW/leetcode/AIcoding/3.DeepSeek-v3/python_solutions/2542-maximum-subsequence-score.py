import heapq

class Solution:
    def maxScore(self, nums1: List[int], nums2: List[int], k: int) -> int:
        pairs = sorted(zip(nums1, nums2), key=lambda x: -x[1])
        max_heap = []
        sum_heap = 0
        res = 0

        for num1, num2 in pairs:
            heapq.heappush(max_heap, num1)
            sum_heap += num1
            if len(max_heap) > k:
                sum_heap -= heapq.heappop(max_heap)
            if len(max_heap) == k:
                res = max(res, sum_heap * num2)

        return res