class Solution:
    def jump(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0

        jumps = 0
        current_reach_end = 0  # The farthest index reachable with the current number of jumps
        next_reach_end = 0     # The farthest index reachable with one more jump

        for i in range(n):
            # Update the farthest point reachable with one more jump
            next_reach_end = max(next_reach_end, i + nums[i])

            # If we have reached the end of the current jump's reach
            if i == current_reach_end:
                # Increment the number of jumps
                jumps += 1
                # Update the current jump's reach to the new farthest point
                current_reach_end = next_reach_end

                # If the new current_reach_end covers or surpasses the last index, we are done
                if current_reach_end >= n - 1:
                    return jumps

        # This line should ideally not be reached if the problem guarantees a solution.
        # It implies that the last index was not reached, which contradicts the problem statement.
        return jumps