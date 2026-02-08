from collections import defaultdict

class Solution:
    def numTriplets(self, nums1: list[int], nums2: list[int]) -> int:
        def count_triplets(nums1, nums2):
            count = 0
            freq = defaultdict(int)
            for num in nums2:
                freq[num] += 1

            for i in range(len(nums1)):
                square = nums1[i] * nums1[i]
                for j in range(len(nums2)):
                    if square % nums2[j] == 0:
                        target = square // nums2[j]
                        if target in freq:
                            if target == nums2[j]:
                                count += freq[target] - (j < len(nums2) and nums2[j] == target)
                            else:
                                count += freq[target]
            return count

        return count_triplets(nums1, nums2) + count_triplets(nums2, nums1)