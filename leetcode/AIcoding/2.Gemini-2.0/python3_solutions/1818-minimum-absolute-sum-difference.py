class Solution:
    def minAbsoluteSumDifference(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)
        abs_diff = [abs(nums1[i] - nums2[i]) for i in range(n)]
        total_sum = sum(abs_diff)
        max_reduction = 0
        sorted_nums1 = sorted(nums1)
        for i in range(n):
            diff = abs(nums1[i] - nums2[i])

            l, r = 0, n - 1
            closest = float('inf')

            while l <= r:
                mid = (l + r) // 2
                if sorted_nums1[mid] >= nums2[i]:
                    closest = sorted_nums1[mid]
                    r = mid - 1
                else:
                    l = mid + 1

            if closest != float('inf'):
                max_reduction = max(max_reduction, diff - abs(closest - nums2[i]))

            l, r = 0, n - 1
            closest = float('inf')

            while l <= r:
                mid = (l + r) // 2
                if sorted_nums1[mid] <= nums2[i]:
                    closest = sorted_nums1[mid]
                    l = mid + 1
                else:
                    r = mid - 1

            if closest != float('inf'):
                max_reduction = max(max_reduction, diff - abs(closest - nums2[i]))

        return (total_sum - max_reduction) % (10**9 + 7)