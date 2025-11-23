class Solution:
    def minKBitFlips(self, nums: list[int], K: int) -> int:
        n = len(nums)
        flips = 0

        # This array tracks whether a flip started at index i.
        # It's essentially a difference array.
        # is_flipped_at_start[j] = 1 means a flip was initiated at index j.
        is_flipped_at_start = [0] * n 

        # current_active_flips counts how many flips are currently affecting nums[i].
        # A flip started at index `j` affects `nums[j]` through `nums[j+K-1]`.
        # So, for nums[i], we need to count flips that started in the range [i-K+1, i].
        current_active_flips = 0 

        for i in range(n):
            # If a flip started at `i-K`, its effect ends before the current position `i`.
            # So, we decrement `current_active_flips`.
            if i >= K and is_flipped_at_start[i - K] == 1:
                current_active_flips -= 1

            # Calculate the effective value of nums[i].
            # If current_active_flips is odd, nums[i] has been effectively flipped an odd number of times,
            # meaning its current state is inverted from its original value.
            effective_val = nums[i]
            if current_active_flips % 2 == 1:
                effective_val = 1 - effective_val # Invert the bit

            # If the effective value of nums[i] is 0, we must perform a flip starting at i.
            if effective_val == 0:
                # Check if we can perform a flip of length K starting at i.
                # The problem states: "choose any i such that 0 <= i <= nums.length - K".
                # This means a flip starting at `i` must not go beyond `n-1`.
                # So, `i + K - 1` must be less than `n`, which means `i + K <= n`.
                # If `i + K > n`, it's impossible to perform a flip of length K starting at `i`.
                if i + K > n:
                    return -1 # Impossible to make all bits 1

                flips += 1
                is_flipped_at_start[i] = 1 # Mark that a flip started at this index
                current_active_flips += 1 # This new flip is now active for nums[i] and subsequent K-1 elements

        return flips