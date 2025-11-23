from collections import defaultdict

class Solution:
    def fourSumCount(self, nums1: list[int], nums2: list[int], nums3: list[int], nums4: list[int]) -> int:
        count = 0
        sum_ab_counts = defaultdict(int)

        for n1 in nums1:
            for n2 in nums2:
                sum_ab_counts[n1 + n2] += 1

        for n3 in nums3:
            for n4 in nums4:
                target_sum = -(n3 + n4)
                if target_sum in sum_ab_counts:
                    count += sum_ab_counts[target_sum]

        return count