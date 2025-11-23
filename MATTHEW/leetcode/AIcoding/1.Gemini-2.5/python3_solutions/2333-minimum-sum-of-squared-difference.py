import collections

class Solution:
    def minSumSquareDiff(self, nums1: list[int], nums2: list[int], k1: int, k2: int) -> int:
        n = len(nums1)

        # Calculate initial absolute differences and find the maximum difference
        max_diff = 0
        diffs_counts = collections.defaultdict(int)
        for i in range(n):
            d = abs(nums1[i] - nums2[i])
            diffs_counts[d] += 1
            if d > max_diff:
                max_diff = d

        # If all initial differences are zero, the sum of squares is already zero
        if max_diff == 0:
            return 0

        k = k1 + k2

        # Use a frequency array for differences, up to max_diff
        # This allows efficient iteration from largest differences downwards
        # Using a list (array) is faster than defaultdict for dense integer keys
        # The size of counts array is max_diff + 1, where max_diff can be up to 10^5
        counts = [0] * (max_diff + 1)
        for d, count in diffs_counts.items():
            counts[d] = count

        current_diff = max_diff
        while k > 0 and current_diff > 0:
            if counts[current_diff] > 0:
                num_elements_at_current_diff = counts[current_diff]

                if k >= num_elements_at_current_diff:
                    # We have enough operations to reduce all elements with current_diff by 1
                    k -= num_elements_at_current_diff
                    counts[current_diff - 1] += num_elements_at_current_diff
                    counts[current_diff] = 0
                else:
                    # We only have 'k' operations left, so reduce 'k' elements by 1
                    counts[current_diff] -= k
                    counts[current_diff - 1] += k
                    k = 0 # All operations are used

            current_diff -= 1

        # Calculate the final sum of squares
        total_sum_sq = 0
        for i in range(max_diff + 1):
            total_sum_sq += i * i * counts[i]

        return total_sum_sq