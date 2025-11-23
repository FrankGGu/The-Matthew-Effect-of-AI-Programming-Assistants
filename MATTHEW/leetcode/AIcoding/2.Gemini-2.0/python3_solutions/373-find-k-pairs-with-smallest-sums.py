import heapq

class Solution:
    def kSmallestPairs(self, nums1: list[int], nums2: list[int], k: int) -> list[list[int]]:
        result = []
        heap = []

        if not nums1 or not nums2 or k <= 0:
            return result

        for i in range(min(len(nums1), k)):
            heapq.heappush(heap, (nums1[i] + nums2[0], i, 0))

        while k > 0 and heap:
            sum_val, i, j = heapq.heappop(heap)
            result.append([nums1[i], nums2[j]])
            k -= 1

            if j + 1 < len(nums2):
                heapq.heappush(heap, (nums1[i] + nums2[j+1], i, j+1))

        return result