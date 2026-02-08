class Solution:
    def kthSmallestProduct(self, nums1: List[int], nums2: List[int], k: int) -> int:
        def count(mid):
            cnt = 0
            for i in range(len(nums1)):
                if nums1[i] >= 0:
                    l, r = 0, len(nums2) - 1
                    while l <= r:
                        m = (l + r) // 2
                        if nums1[i] * nums2[m] <= mid:
                            l = m + 1
                        else:
                            r = m - 1
                    cnt += l
                else:
                    l, r = 0, len(nums2) - 1
                    while l <= r:
                        m = (l + r) // 2
                        if nums1[i] * nums2[m] <= mid:
                            r = m - 1
                        else:
                            l = m + 1
                    cnt += len(nums2) - l
            return cnt

        l = -10**10
        r = 10**10
        while l < r:
            mid = (l + r) // 2
            if count(mid) < k:
                l = mid + 1
            else:
                r = mid
        return l