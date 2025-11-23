import collections

class Solution:
    def minOperations(self, nums: list[int], k: int) -> int:
        n = len(nums)
        operations = 0

        # current_flips_count tracks the number of active flips affecting the current position `i`.
        # An active flip is one that started at index `j` such that `j <= i` and `j + k - 1 >= i`.
        # This means `i - k + 1 <= j <= i`.
        current_flips_count = 0

        # A deque to store the starting indices of active flips.
        # When a flip starting at `j` is no longer active for index `i`, it means `i = j + k`.
        # So, we remove `j` from the deque when `i - k == j`.
        active_flip_starts = collections.deque()

        for i in range(n):
            # Remove flips that are no longer active at the current index `i`.
            # A flip starting at `active_flip_starts[0]` affects elements up to `active_flip_starts[0] + k - 1`.
            # If `i` is `active_flip_starts[0] + k`, then this flip no longer affects `nums[i]`.
            # So, `active_flip_starts[0] == i - k`.
            while active_flip_starts and active_flip_starts[0] == i - k:
                active_flip_starts.popleft()
                current_flips_count -= 1

            # Determine the effective value of nums[i] after all active flips.
            # If current_flips_count is odd, it means nums[i] is effectively flipped.
            # If current_flips_count is even, nums[i] retains its original parity.
            effective_val = (nums[i] + current_flips_count) % 2

            # If the effective value is 1, we need to perform an operation to make it 0.
            if effective_val == 1:
                # We must start an operation at index `i`.
                # Check if it's possible to start an operation at `i` (i.e., `i + k - 1 < n`).
                # This is equivalent to `i <= n - k`.
                if i + k > n:
                    # If we cannot start an operation at `i` without going out of bounds,
                    # it's impossible to make nums[i] zero.
                    return -1

                operations += 1
                current_flips_count += 1
                active_flip_starts.append(i) # Mark that a flip started at `i`.

        return operations