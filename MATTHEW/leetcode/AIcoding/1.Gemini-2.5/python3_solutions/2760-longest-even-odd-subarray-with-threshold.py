class Solution:
    def longestEvenOddSubarray(self, nums: list[int], threshold: int) -> int:
        max_len = 0
        current_len = 0

        for i in range(len(nums)):
            if current_len == 0:
                # Try to start a new subarray
                if nums[i] % 2 == 0 and nums[i] <= threshold:
                    current_len = 1
                # else: current_len remains 0
            else: # current_len > 0, try to extend
                # Check if nums[i] extends the current subarray
                # It must be within threshold and have different parity than nums[i-1]
                if nums[i] <= threshold and (nums[i] % 2 != nums[i-1] % 2):
                    current_len += 1
                else:
                    # Current subarray breaks.
                    # Now, check if nums[i] can start a NEW subarray.
                    current_len = 0 
                    if nums[i] % 2 == 0 and nums[i] <= threshold:
                        current_len = 1

            max_len = max(max_len, current_len)

        return max_len