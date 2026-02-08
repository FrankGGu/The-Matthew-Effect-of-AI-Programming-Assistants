import collections

class Solution:
    def minimumOperations(self, nums: list[int], k: int) -> int:
        n = len(nums)

        active_operations = collections.deque()

        current_increment_from_ops = 0
        total_operations = 0

        for i in range(n):
            while active_operations and active_operations[0][0] <= i:
                end_idx, count = active_operations.popleft()
                current_increment_from_ops -= count

            effective_val_at_i = nums[i] + current_increment_from_ops

            if effective_val_at_i < k:
                needed = k - effective_val_at_i

                total_operations += needed

                current_increment_from_ops += needed

                active_operations.append((i + k, needed))

        return total_operations