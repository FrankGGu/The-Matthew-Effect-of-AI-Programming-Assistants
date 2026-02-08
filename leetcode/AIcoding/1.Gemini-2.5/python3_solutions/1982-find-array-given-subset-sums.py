import collections
import math

class Solution:
    def findArray(self, sums: list[int]) -> list[int]:
        n = int(math.log2(len(sums)))
        ans = []
        current_sums = sorted(sums)

        for _ in range(n):
            # The smallest difference between any two sums in the sorted list
            # (specifically, current_sums[1] - current_sums[0])
            # will be the absolute value of one of the numbers in the current array.
            # current_sums[0] represents the sum of all negative numbers in the current 'nums'.
            # current_sums[1] represents current_sums[0] + |smallest_absolute_value_number|.
            x_val = current_sums[1] - current_sums[0]

            # We need to decide whether the actual number to extract is x_val or -x_val.
            # Let S_neg be the sum of negative numbers in the current 'nums' (which is current_sums[0]).
            # If we extract x_val (assuming it's positive):
            #   The sum of negative numbers in the remaining 'nums' will still be S_neg.
            # If we extract -x_val (assuming it's negative):
            #   The sum of negative numbers in the remaining 'nums' will be S_neg - (-x_val) = S_neg + x_val.
            # To reconstruct the original array, we should choose the number (x_val or -x_val)
            # that makes the sum of negative numbers in the *next* iteration closer to zero.
            # This is achieved by comparing abs(S_neg) with abs(S_neg + x_val).

            if abs(current_sums[0] + x_val) < abs(current_sums[0]):
                chosen_num = -x_val
            else:
                chosen_num = x_val

            ans.append(chosen_num)

            # Now, form the 'next_sums' array by effectively removing 'chosen_num' from the problem.
            # The 'current_sums' array is composed of two sets of sums:
            # 1. S_without_num: sums that do not include 'chosen_num'.
            # 2. S_with_num: sums that include 'chosen_num' (i.e., {s + chosen_num | s in S_without_num}).
            # We want to extract S_without_num to become the 'current_sums' for the next iteration.

            next_sums = []
            count = collections.Counter(current_sums)

            for s in current_sums:
                if count[s] > 0:
                    # 's' is a sum that does not include 'chosen_num'.
                    # So, we add 's' to 'next_sums'.
                    next_sums.append(s)

                    # Decrement counts for 's' and 's + chosen_num'
                    # because they form a pair (sum without 'chosen_num', sum with 'chosen_num').
                    count[s] -= 1
                    count[s + chosen_num] -= 1

            # Sort 'next_sums' to maintain the invariant for the next iteration.
            current_sums = sorted(next_sums)

        return ans