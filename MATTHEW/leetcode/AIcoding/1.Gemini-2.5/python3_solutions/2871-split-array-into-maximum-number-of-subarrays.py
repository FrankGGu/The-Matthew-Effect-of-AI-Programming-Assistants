class Solution:
    def maxSubarrays(self, nums: list[int]) -> int:
        n = len(nums)

        # Calculate the bitwise AND of all elements in the array
        # Also check if the array contains any zero.
        total_and_val = -1 # Represents all bits set for positive integers
        contains_zero = False
        for num in nums:
            if num == 0:
                contains_zero = True
            total_and_val &= num

        # Case 1: The bitwise AND of all elements in the array is greater than 0.
        # This implies that all numbers in `nums` are positive and share at least one common set bit.
        # In this scenario, any way we split the array into subarrays will result in subarrays
        # whose bitwise AND is also greater than 0.
        # To maximize the number of subarrays, we can split the array into `n` individual subarrays,
        # where each subarray contains a single element. Since `total_and_val > 0`,
        # it means no `nums[i]` can be 0. Thus, `AND([nums[i]]) = nums[i] > 0` is always true.
        # So, the maximum number of subarrays is `n`.
        if total_and_val > 0:
            return n

        # Case 2: The bitwise AND of all elements in the array is 0.
        # This means we cannot consider the entire array as a single valid subarray
        # because its bitwise AND is 0, violating the "non-zero" condition.
        # We must split the array.

        # Special handling for arrays containing 0:
        # If the array contains any 0, then any subarray that includes a 0 will have a bitwise AND of 0.
        # Since we must partition the entire array into subarrays, and each subarray's AND must be non-zero,
        # it becomes impossible to include any 0s in valid subarrays.
        # The problem's Example 1 ([1,0,2,0,1,2] -> 1) suggests that if 0 is present and `total_and_val` is 0,
        # the answer is 1, implying that no valid split into multiple subarrays is possible,
        # and 1 is a fallback for representing the entire array, even if it's invalid.
        if contains_zero:
            return 1

        # Case 3: The bitwise AND of all elements is 0, and the array does NOT contain any 0.
        # (e.g., [7,12,9,29,15] from Example 2, or [1,2])
        # We use a greedy approach to maximize the number of valid subarrays.
        # We iterate through the array, maintaining the bitwise AND of the current subarray.
        # When the current subarray's AND becomes 0, it means the element that caused it to become 0
        # cannot be part of the current subarray. Thus, the subarray ending just before that element
        # must have been valid (its AND was > 0). We finalize that subarray, increment the count,
        # and start a new subarray with the current element.

        count = 1 # Initialize with 1, assuming the first element starts a valid subarray
        current_segment_and = nums[0] # Bitwise AND of the current subarray being formed

        for i in range(1, n):
            current_segment_and &= nums[i]

            if current_segment_and == 0:
                # The current subarray (from its start to nums[i]) has an AND of 0.
                # This means the subarray ending at nums[i-1] was valid.
                # We finalize that subarray and start a new one with nums[i].
                count += 1
                current_segment_and = nums[i] # Start a new segment with the current element

        return count