class Solution:
    def maximumSetSize(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        s1 = set(nums1)
        s2 = set(nums2)

        n_half = n // 2

        # Calculate the maximum number of distinct elements we can effectively take from nums1.
        # This is limited by the actual number of unique elements in s1 (len(s1))
        # and the maximum allowed picks from nums1 (n_half).
        unique_from_s1_effective = min(len(s1), n_half)

        # Calculate the maximum number of distinct elements we can effectively take from nums2.
        # This is limited by the actual number of unique elements in s2 (len(s2))
        # and the maximum allowed picks from nums2 (n_half).
        unique_from_s2_effective = min(len(s2), n_half)

        # The sum of these two effective counts represents the maximum number of unique elements
        # we could potentially form if there were no overlap between s1 and s2.
        # This sum also serves as an upper bound, as we can't pick more unique elements than
        # the sum of the individual 'budgets' for unique elements from each array.
        potential_total_unique_from_budgets = unique_from_s1_effective + unique_from_s2_effective

        # The actual number of unique elements in the final set cannot exceed the total
        # number of unique elements present across both original arrays (the union of s1 and s2).
        actual_total_unique_available = len(s1 | s2)

        # The maximum size of the resulting set is limited by both of these factors.
        # We take the minimum, as it represents the tightest upper bound.
        return min(potential_total_unique_from_budgets, actual_total_unique_available)