class Solution:
    def jump(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0

        jumps = 0
        current_end = 0  # The farthest index reachable with 'jumps' jumps
        farthest = 0     # The farthest index reachable with 'jumps + 1' jumps

        for i in range(n - 1):
            farthest = max(farthest, i + nums[i])

            # If we've reached the end of the current jump's reach
            if i == current_end:
                jumps += 1
                current_end = farthest

                # If the new 'current_end' can reach or surpass the last index,
                # we've found the minimum jumps.
                if current_end >= n - 1:
                    break

        return jumps