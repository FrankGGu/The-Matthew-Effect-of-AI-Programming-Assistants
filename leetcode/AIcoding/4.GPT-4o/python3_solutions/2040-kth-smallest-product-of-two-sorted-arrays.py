class Solution:
    def kthSmallestProduct(self, nums1: List[int], nums2: List[int], k: int) -> int:
        def countLessEqual(x):
            count = 0
            for num in nums1:
                if num <= 0:
                    if num * nums2[0] <= x:
                        count += len(nums2)
                    else:
                        count += bisect.bisect_right(nums2, x // num)
                else:
                    count += bisect.bisect_right(nums2, x // num)
            return count

        left, right = 0, nums1[-1] * nums2[-1]
        while left < right:
            mid = (left + right) // 2
            if countLessEqual(mid) < k:
                left = mid + 1
            else:
                right = mid
        return left