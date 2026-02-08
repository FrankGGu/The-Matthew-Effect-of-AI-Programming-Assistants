class Solution:
    def minNumberOfSemesters(self, n: int, relations: list[list[int]], k: int) -> int:
        # Helper function to count set bits in an integer (popcount)
        # This is used because int.bit_count() is available from Python 3.10+
        # and LeetCode's Python version might be older.
        def count_set_bits(num):
            count = 0
            while num > 0:
                num &= (num - 1)
                count += 1
            return count

        # Step 1: Precompute prerequisite masks for each course.
        # pre_req_masks[i] will be a bitmask where the j-th bit is set
        # if course j is a prerequisite for course i.
        # Courses are 1-indexed in the problem, convert to 0-indexed for bitmasks.
        pre_req_masks = [0] * n
        for p, nxt in relations:
            pre_req_masks[nxt - 1] |= (1 << (p - 1))

        # Step 2: Initialize DP array.
        # dp[mask] = minimum number of semesters to complete courses represented by 'mask'.
        # Initialize with infinity, dp[0] = 0 (0 semesters for no courses completed).
        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        # Step 3: Iterate through all possible masks (states) in increasing order.
        # This ensures that when we compute dp[next_mask], dp[mask] has already been finalized.
        for mask in range(1 << n):
            if dp[mask] == float('inf'):
                continue  # This state is unreachable

            # Step 4: Determine which courses are eligible to be taken in the current semester.
            # A course 'i' is eligible if:
            # 1. It has not yet been taken (i.e., the i-th bit is not set in 'mask').
            # 2. All its prerequisites have been completed (i.e., all bits set in pre_req_masks[i]
            #    are also set in 'mask').
            eligible_to_take_mask = 0
            for i in range(n):
                if not ((mask >> i) & 1):  # Course i is not yet taken
                    if (pre_req_masks[i] & mask) == pre_req_masks[i]:  # All prerequisites for i are met
                        eligible_to_take_mask |= (1 << i)

            # If no courses are eligible to be taken, continue to the next state.
            # This can happen if all courses are completed, or if we are stuck.
            if eligible_to_take_mask == 0:
                continue

            # Step 5: Iterate through all possible non-empty subsets of eligible courses
            # to take in this semester. A subset must have at most 'k' courses.

            # Start with the full set of eligible courses and iterate downwards through its submasks.
            current_semester_courses_mask = eligible_to_take_mask
            while current_semester_courses_mask > 0:
                # Check if the number of courses in this subset is at most k.
                if count_set_bits(current_semester_courses_mask) <= k:
                    # Calculate the next state by adding these courses to the current 'mask'.
                    next_mask = mask | current_semester_courses_mask
                    # Update the minimum semesters required for the 'next_mask' state.
                    dp[next_mask] = min(dp[next_mask], dp[mask] + 1)

                # Move to the next smaller submask of eligible_to_take_mask.
                # This trick efficiently iterates all submasks.
                current_semester_courses_mask = (current_semester_courses_mask - 1) & eligible_to_take_mask

        # The final answer is the minimum semesters to complete all courses,
        # which is represented by the mask (1 << n) - 1 (all bits set).
        return dp[(1 << n) - 1]