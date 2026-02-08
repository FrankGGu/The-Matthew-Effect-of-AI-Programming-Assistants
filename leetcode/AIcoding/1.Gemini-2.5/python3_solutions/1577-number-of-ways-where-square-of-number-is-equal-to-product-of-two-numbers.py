from typing import List

class Solution:
    def numTriplets(self, nums1: List[int], nums2: List[int]) -> int:

        def count_matches(arr1: List[int], arr2: List[int]) -> int:
            count = 0
            # Precompute products of pairs in arr2 and store their frequencies
            # map: product -> frequency
            products_freq = {}
            n2 = len(arr2)
            for j in range(n2):
                for k in range(j + 1, n2):
                    prod = arr2[j] * arr2[k]
                    products_freq[prod] = products_freq.get(prod, 0) + 1

            # For each number in arr1, calculate its square and check if it exists in products_freq
            for x in arr1:
                target_sq = x * x
                count += products_freq.get(target_sq, 0)

            return count

        # Calculate Type 1 triplets: nums1[i]^2 == nums2[j] * nums2[k]
        ans = count_matches(nums1, nums2)

        # Calculate Type 2 triplets: nums2[i]^2 == nums1[j] * nums1[k]
        ans += count_matches(nums2, nums1)

        return ans