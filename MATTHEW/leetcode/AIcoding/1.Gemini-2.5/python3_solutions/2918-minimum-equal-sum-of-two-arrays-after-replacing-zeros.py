class Solution:
    def minimumEqualSum(self, nums1: list[int], nums2: list[int]) -> int:
        sum1 = 0
        zeros1 = 0
        for x in nums1:
            if x == 0:
                zeros1 += 1
            sum1 += x

        sum2 = 0
        zeros2 = 0
        for x in nums2:
            if x == 0:
                zeros2 += 1
            sum2 += x

        # Calculate minimum possible sum for each array
        # If an array has zeros, its minimum sum is current_sum + count_of_zeros (replacing each zero with 1)
        # If an array has no zeros, its sum is fixed.

        min_possible_sum1 = sum1 + zeros1
        min_possible_sum2 = sum2 + zeros2

        # Case 1: Both arrays have zeros
        if zeros1 > 0 and zeros2 > 0:
            # Both arrays can achieve any sum greater than or equal to their minimum possible sum.
            # The minimum equal sum will be the maximum of their individual minimums.
            return max(min_possible_sum1, min_possible_sum2)

        # Case 2: Only nums1 has zeros (nums2 has no zeros)
        if zeros1 > 0 and zeros2 == 0:
            # nums1 can achieve any sum >= min_possible_sum1
            # nums2's sum is fixed at sum2
            # For them to be equal, sum2 must be achievable by nums1, i.e., sum2 >= min_possible_sum1
            if sum2 >= min_possible_sum1:
                return sum2
            else:
                return -1 # Impossible to make them equal

        # Case 3: Only nums2 has zeros (nums1 has no zeros)
        if zeros1 == 0 and zeros2 > 0:
            # nums2 can achieve any sum >= min_possible_sum2
            # nums1's sum is fixed at sum1
            # For them to be equal, sum1 must be achievable by nums2, i.e., sum1 >= min_possible_sum2
            if sum1 >= min_possible_sum2:
                return sum1
            else:
                return -1 # Impossible to make them equal

        # Case 4: Neither array has zeros (both zeros1 == 0 and zeros2 == 0)
        # Both arrays have fixed sums.
        # For them to be equal, their fixed sums must be identical.
        if sum1 == sum2:
            return sum1
        else:
            return -1 # Impossible to make them equal