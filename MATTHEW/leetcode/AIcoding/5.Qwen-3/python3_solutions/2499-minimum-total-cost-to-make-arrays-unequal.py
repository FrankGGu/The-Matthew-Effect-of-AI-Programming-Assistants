from typing import List

class Solution:
    def minTotalCost(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import Counter

        count1 = Counter(nums1)
        count2 = Counter(nums2)

        total_cost = 0

        for num in count1:
            if num in count2:
                total_cost += abs(count1[num] - count2[num]) * num

        for num in count2:
            if num not in count1:
                total_cost += count2[num] * num

        return total_cost