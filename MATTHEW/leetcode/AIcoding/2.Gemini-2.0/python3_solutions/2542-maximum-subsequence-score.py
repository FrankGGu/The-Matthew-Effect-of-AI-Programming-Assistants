import heapq

class Solution:
    def maxScore(self, nums1: list[int], nums2: list[int], k: int) -> int:
        pairs = sorted(zip(nums1, nums2), key=lambda x: x[1], reverse=True)
        top_k_nums1 = []
        sum_nums1 = 0
        for i in range(k):
            sum_nums1 += pairs[i][0]
            heapq.heappush(top_k_nums1, pairs[i][0])

        max_score = sum_nums1 * pairs[k-1][1]

        for i in range(k, len(nums1)):
            sum_nums1 -= heapq.heappop(top_k_nums1)
            sum_nums1 += pairs[i][0]
            heapq.heappush(top_k_nums1, pairs[i][0])
            max_score = max(max_score, sum_nums1 * pairs[i][1])

        return max_score