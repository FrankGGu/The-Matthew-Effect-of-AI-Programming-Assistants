class Solution:
    def goodPartitions(self, nums: list[int]) -> int:
        # Step 1: Precompute the last occurrence index for each number in nums.
        # This dictionary will map a number to the largest index where it appears.
        last_occurrence = {}
        for i, num in enumerate(nums):
            last_occurrence[num] = i

        # Step 2: Iterate through the array to find the number of "independent" segments.
        # An independent segment is a contiguous subarray where all numbers within it
        # have their last occurrences also within that same subarray.

        num_independent_segments = 0

        # max_reach_in_current_segment tracks the maximum index that any number
        # encountered *since the last segment cut* (or start of array) must reach.
        # This ensures that if a number 'x' appears in the current segment,
        # all its occurrences up to its last one are contained within this segment.
        max_reach_in_current_segment = 0 

        for i in range(len(nums)):
            # Update max_reach_in_current_segment: it must be at least the last
            # occurrence of the current number nums[i], and also at least the
            # max_reach calculated from previous numbers in this segment.
            max_reach_in_current_segment = max(max_reach_in_current_segment, last_occurrence[nums[i]])

            # If the current index 'i' has reached max_reach_in_current_segment,
            # it means that all numbers from the start of the current segment up to 'i'
            # have their last occurrences within the range [start_of_current_segment, i].
            # This signifies the end of a valid, minimal "good" segment.
            if i == max_reach_in_current_segment:
                num_independent_segments += 1
                # At this point, a segment has ended. The `max_reach_in_current_segment`
                # for the *next* segment will naturally be determined by the elements
                # starting from `i+1`. No explicit reset of `max_reach_in_current_segment`
                # is needed, as the `max` operation in the next iteration will correctly
                # establish the new maximum reach based on `last_occurrence[nums[i+1]]`
                # and subsequent elements.

        # Step 3: Calculate the total number of good partitions.
        # If there are `k` independent segments (e.g., S1, S2, ..., Sk),
        # there are `k-1` potential "cut points" between these segments.
        # For each cut point, we can either make a partition boundary or not.
        # This gives 2^(k-1) possible ways to form good partitions.
        # For example, if k=3, segments are S1, S2, S3. Potential cuts at S1|S2 and S2|S3.
        # Partitions: S1|S2|S3, S1S2|S3, S1|S2S3, S1S2S3. Total 2^(3-1) = 4.

        # The result should be returned modulo 10^9 + 7.
        MOD = 10**9 + 7

        # Since nums.length >= 1, num_independent_segments will always be at least 1.
        # If num_independent_segments is 1, then 2^(1-1) = 2^0 = 1, which is correct
        # (only one partition: the entire array itself).
        return pow(2, num_independent_segments - 1, MOD)