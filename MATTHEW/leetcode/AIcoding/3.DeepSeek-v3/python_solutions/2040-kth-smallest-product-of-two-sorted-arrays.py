class Solution:
    def kthSmallestProduct(self, nums1: List[int], nums2: List[int], k: int) -> int:
        def count_leq(mid):
            cnt = 0
            for num in nums1:
                if num == 0:
                    if mid >= 0:
                        cnt += len(nums2)
                elif num > 0:
                    left, right = 0, len(nums2)
                    while left < right:
                        mid2 = (left + right) // 2
                        if num * nums2[mid2] <= mid:
                            left = mid2 + 1
                        else:
                            right = mid2
                    cnt += left
                else:
                    left, right = 0, len(nums2)
                    while left < right:
                        mid2 = (left + right) // 2
                        if num * nums2[mid2] <= mid:
                            right = mid2
                        else:
                            left = mid2 + 1
                    cnt += len(nums2) - left
            return cnt

        left, right = -10**10 - 1, 10**10 + 1
        while left < right:
            mid = (left + right) // 2
            if count_leq(mid) < k:
                left = mid + 1
            else:
                right = mid
        return left