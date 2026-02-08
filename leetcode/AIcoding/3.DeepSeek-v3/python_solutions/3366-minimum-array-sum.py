class Solution:
    def minSum(self, nums1: List[int], nums2: List[int]) -> int:
        sum1 = sum(nums1)
        sum2 = sum(nums2)
        cnt1 = nums1.count(0)
        cnt2 = nums2.count(0)

        if cnt1 == 0 and cnt2 == 0:
            if sum1 != sum2:
                return -1
            else:
                return sum1
        elif cnt1 == 0:
            if sum1 < sum2 + cnt2:
                return -1
            else:
                return sum1
        elif cnt2 == 0:
            if sum2 < sum1 + cnt1:
                return -1
            else:
                return sum2
        else:
            return max(sum1 + cnt1, sum2 + cnt2)