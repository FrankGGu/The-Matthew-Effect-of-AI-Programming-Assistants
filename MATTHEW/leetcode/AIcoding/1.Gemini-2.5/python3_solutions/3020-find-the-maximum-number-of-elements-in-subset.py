import math

class Solution:
    def findMaximumNumberofElementsInSubset(self, nums: list[int]) -> int:
        nums_set = set(nums)
        max_len_excluding_one = 0

        for num in nums:
            if num == 1:
                continue

            # Check if num is a "root" for a chain.
            # A number `num` is considered a root if its square root `s` is not an integer,
            # or if `s` is an integer but `s` is not present in nums_set.
            # This ensures we only start counting a chain from its smallest possible base element,
            # avoiding redundant calculations for elements that are squares of other elements already in a chain.
            s_float = math.sqrt(num)
            s_int = int(s_float)
            if s_int * s_int == num and s_int in nums_set:
                # num is a perfect square of s_int, and s_int is present in nums_set.
                # This means num would be part of a chain starting from s_int.
                # We skip it to avoid processing sub-chains.
                continue

            # Start building a chain from 'num'
            current_len = 0
            current_val = num
            while current_val in nums_set:
                current_len += 1
                # Optimization: if current_val is already very large, its square will exceed
                # the maximum possible value in nums (10^9), so its square won't be in nums_set.
                # This check prevents unnecessary calculations for very large numbers.
                if current_val > 10**9: 
                    break
                current_val *= current_val

            max_len_excluding_one = max(max_len_excluding_one, current_len)

        # Handle the special case of '1'.
        # If '1' is present in nums_set, it can always form a valid subset {1} of length 1.
        # Furthermore, '1' can be added to any other valid chain (e.g., {2, 4, 16})
        # to form a larger valid subset (e.g., {1, 2, 4, 16}).
        # Since chains starting with numbers > 1 do not include 1 (unless the chain is just {1} itself, which is handled by the initial `num == 1` check),
        # adding 1 to the maximum length found for chains starting with x > 1 is correct.
        # If no chains for x > 1 are found, and 1 is present, the result will be 0 + 1 = 1.
        if 1 in nums_set:
            return max_len_excluding_one + 1
        else:
            return max_len_excluding_one