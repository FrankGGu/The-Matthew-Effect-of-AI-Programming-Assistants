class Solution:
    def countSubarrays(self, nums: list[int]) -> int:
        ans = 0
        # Stack stores (value, count) pairs.
        # 'value' is nums[j] for some index j.
        # 'count' is the number of valid left boundaries for subarrays ending at j,
        # where nums[j] is the right boundary and also the maximum in that subarray.
        st = [] 

        for num in nums:
            # current_valid_left_boundaries will store the count of valid 'l' indices
            # for the current 'num' (which is nums[i] for the current iteration i).
            # Initialize with 1 for the subarray [num] itself (l=i, r=i).
            current_valid_left_boundaries = 1

            # Pop elements from stack whose value is strictly less than current num.
            # These elements cannot be a left boundary for 'num' because 'num' is strictly greater.
            while st and st[-1][0] < num:
                st.pop()

            # If stack is not empty and the top element's value is equal to current num:
            # This means st[-1][0] represents the value of a previous element (at some index j)
            # which is equal to 'num'. All elements between j and the current index i (that were on the stack)
            # must have been smaller than 'num' (and thus popped).
            # This ensures that 'num' is the maximum in the subarray from j to i.
            # Therefore, j is a valid left boundary for the current 'num'.
            # Furthermore, any 'l' that was a valid left boundary for j (i.e., nums[l...j] was valid)
            # is also a valid left boundary for 'num' (i.e., nums[l...i] is valid).
            # We add st[-1][1] (which is the count of valid left boundaries for j)
            # to current_valid_left_boundaries.
            if st and st[-1][0] == num:
                current_valid_left_boundaries += st[-1][1]

            # Add the total count of valid left boundaries for the current 'num' to the overall answer.
            ans += current_valid_left_boundaries

            # Push the current (num, current_valid_left_boundaries) pair onto the stack.
            # This pair represents the current 'num' as a potential future left boundary.
            st.append((num, current_valid_left_boundaries))

        return ans