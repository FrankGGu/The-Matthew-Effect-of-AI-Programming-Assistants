class Solution:
    def findMedianSortedArrays(self, nums1: list[int], nums2: list[int]) -> float:
        m, n = len(nums1), len(nums2)
        total_length = m + n

        def findKthSmallest(A, B, k):
            if len(A) > len(B):
                A, B = B, A

            if len(A) == 0:
                return B[k - 1]
            if k == 1:
                return min(A[0], B[0])

            pa = min(k // 2, len(A))
            pb = k - pa

            if A[pa - 1] < B[pb - 1]:
                return findKthSmallest(A[pa:], B, k - pa)
            elif A[pa - 1] > B[pb - 1]:
                return findKthSmallest(A, B[pb:], k - pb)
            else:
                return A[pa - 1]

        if total_length % 2 == 1:
            return float(findKthSmallest(nums1, nums2, total_length // 2 + 1))
        else:
            mid1 = findKthSmallest(nums1, nums2, total_length // 2)
            mid2 = findKthSmallest(nums1, nums2, total_length // 2 + 1)
            return (float(mid1) + float(mid2)) / 2.0