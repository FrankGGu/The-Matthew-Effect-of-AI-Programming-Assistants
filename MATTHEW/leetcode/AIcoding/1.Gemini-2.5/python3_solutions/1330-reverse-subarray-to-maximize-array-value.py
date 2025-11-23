import math

class Solution:
    def maxValueAfterReverse(self, nums: list[int]) -> int:
        n = len(nums)

        # Calculate the initial array value
        base_value = 0
        for i in range(n - 1):
            base_value += abs(nums[i] - nums[i+1])

        max_delta = 0

        # Case 1: Reverse subarray starting at index 0 (j=0)
        # The change in value is |nums[0] - nums[k+1]| - |nums[k] - nums[k+1]|
        # for reversing nums[0...k].
        # Iterate k from 0 to n-2 (so k+1 goes from 1 to n-1)
        for k in range(n - 1):
            # Original terms removed: |nums[k] - nums[k+1]|
            # New terms added: |nums[0] - nums[k+1]|
            delta = abs(nums[0] - nums[k+1]) - abs(nums[k] - nums[k+1])
            max_delta = max(max_delta, delta)

        # Case 2: Reverse subarray ending at index n-1 (k=n-1)
        # The change in value is |nums[j-1] - nums[n-1]| - |nums[j-1] - nums[j]|
        # for reversing nums[j...n-1].
        # Iterate j from 1 to n-1 (so j-1 goes from 0 to n-2)
        for j in range(1, n):
            # Original terms removed: |nums[j-1] - nums[j]|
            # New terms added: |nums[j-1] - nums[n-1]|
            delta = abs(nums[j-1] - nums[n-1]) - abs(nums[j-1] - nums[j])
            max_delta = max(max_delta, delta)

        # Case 3: Reverse subarray nums[j...k] where 0 < j <= k < n-1
        # The change in value is |nums[j-1] - nums[k]| + |nums[j] - nums[k+1]| - |nums[j-1] - nums[j]| - |nums[k] - nums[k+1]|
        # Let x1 = nums[j-1], y1 = nums[j], x2 = nums[k], y2 = nums[k+1].
        # We want to maximize |x1-x2| + |y1-y2| - |x1-y1| - |x2-y2|.
        # This expression is equivalent to 2 * (max(min(x1,y1), min(x2,y2)) - min(max(x1,y1), max(x2,y2))).
        # Let m_i = min(nums[i], nums[i+1]) and M_i = max(nums[i], nums[i+1]).
        # We want to maximize 2 * (max(m_j_minus_1, m_k) - min(M_j_minus_1, M_k)).
        # This can be rewritten as 2 * max(m_j_minus_1 - M_k, m_k - M_j_minus_1).
        # We need to find the max of (m_i - M_p) and (m_p - M_i) for i < p.

        min_M_i_so_far = math.inf  # min of max(nums[i], nums[i+1]) encountered for i < p
        max_m_i_so_far = -math.inf # max of min(nums[i], nums[i+1]) encountered for i < p

        # Iterate p from 0 to n-2. Here p represents the index k in the formula.
        # The first pair is (nums[j-1], nums[j]), where j-1 is some index i < p.
        # The second pair is (nums[p], nums[p+1]).
        for p in range(n - 1):
            cur_m = min(nums[p], nums[p+1]) # min of current pair (nums[p], nums[p+1])
            cur_M = max(nums[p], nums[p+1]) # max of current pair (nums[p], nums[p+1])

            # Update max_delta using previous max_m_i_so_far and current cur_M
            # This corresponds to maximizing (m_i - M_p)
            if max_m_i_so_far != -math.inf: # Ensure max_m_i_so_far has been initialized by at least one pair
                max_delta = max(max_delta, 2 * (max_m_i_so_far - cur_M))

            # Update max_delta using current cur_m and previous min_M_i_so_far
            # This corresponds to maximizing (m_p - M_i)
            if min_M_i_so_far != math.inf: # Ensure min_M_i_so_far has been initialized by at least one pair
                max_delta = max(max_delta, 2 * (cur_m - min_M_i_so_far))

            # Update running min/max for the next iteration
            max_m_i_so_far = max(max_m_i_so_far, cur_m)
            min_M_i_so_far = min(min_M_i_so_far, cur_M)

        return base_value + max_delta