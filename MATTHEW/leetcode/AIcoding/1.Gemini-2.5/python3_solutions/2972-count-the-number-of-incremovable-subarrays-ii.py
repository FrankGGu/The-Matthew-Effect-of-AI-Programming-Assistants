class Solution:
    def incremovableSubarrayCount(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0
        if n == 1:
            return 1 # The subarray nums[0...0] can be removed, leaving an empty array.

        # Calculate p_end_idx: the first index k such that nums[0...k-1] is NOT strictly increasing.
        # This means nums[0...p_end_idx-1] IS strictly increasing.
        # If the entire array is strictly increasing, p_end_idx will be n.
        p_end_idx = n
        for k in range(1, n):
            if nums[k-1] >= nums[k]:
                p_end_idx = k
                break

        # Calculate s_start_idx: the first index k such that nums[k...n-1] IS strictly increasing.
        # If the entire array is strictly increasing, s_start_idx will be 0.
        s_start_idx = n - 1 # Base case: nums[n-1...n-1] is strictly increasing (if n > 0)
        if n == 0:
            s_start_idx = 0
        else:
            for k in range(n - 2, -1, -1):
                if nums[k] < nums[k+1]:
                    s_start_idx = k
                else:
                    break

        ans = 0
        j_ptr = s_start_idx # j_ptr represents the start index of the suffix (j+1)

        # Iterate i from 0 to p_end_idx (inclusive).
        # i is the length of the prefix nums[0...i-1].
        # The prefix nums[0...i-1] must be strictly increasing, which is guaranteed by i <= p_end_idx.
        for i in range(p_end_idx + 1):
            # lval is the last element of the prefix nums[0...i-1].
            # If i == 0, the prefix is empty, so lval is effectively -infinity.
            lval = -1 
            if i > 0:
                lval = nums[i-1]

            # The removed subarray is nums[i...j]. For it to be a valid subarray, i <= j.
            # This implies j+1 > i, so j_ptr must be at least i+1.
            # Also, the suffix nums[j_ptr...n-1] must be strictly increasing, so j_ptr must be at least s_start_idx.
            j_ptr = max(j_ptr, i + 1)

            # Find the smallest valid j_ptr for the current i.
            # j_ptr must satisfy:
            # 1. j_ptr >= i + 1 (ensures removed subarray is non-empty)
            # 2. j_ptr >= s_start_idx (ensures suffix is strictly increasing)
            # 3. If j_ptr < n, then lval < nums[j_ptr] (ensures prefix_last < suffix_first)
            while j_ptr < n and lval >= nums[j_ptr]:
                j_ptr += 1

            # All j_plus_1 values from the current j_ptr up to n (inclusive) are valid.
            # j_plus_1 = n corresponds to an empty suffix (removing nums[i...n-1]).
            ans += (n - j_ptr + 1)

        return ans