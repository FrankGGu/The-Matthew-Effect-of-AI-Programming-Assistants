class Solution:
    def minimumTotalCost(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import defaultdict

        n = len(nums1)
        freq = defaultdict(int)
        max_freq = 0
        max_val = -1
        total_swaps = 0
        cost = 0

        for i in range(n):
            if nums1[i] == nums2[i]:
                freq[nums1[i]] += 1
                if freq[nums1[i]] > max_freq:
                    max_freq = freq[nums1[i]]
                    max_val = nums1[i]
                total_swaps += 1
                cost += i

        if max_freq <= total_swaps // 2:
            return cost

        for i in range(n):
            if nums1[i] != nums2[i] and nums1[i] != max_val and nums2[i] != max_val and max_freq > total_swaps // 2:
                total_swaps += 1
                cost += i

        if max_freq <= total_swaps // 2:
            return cost
        else:
            return -1