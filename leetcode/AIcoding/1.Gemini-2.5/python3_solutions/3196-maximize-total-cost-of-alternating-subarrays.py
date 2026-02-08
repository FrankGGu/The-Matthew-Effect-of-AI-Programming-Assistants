class Solution:
    def maximizeTotalCost(self, nums: list[int]) -> int:
        n = len(nums)

        # prev_dp_add: maximum total cost for nums[0...i-1], where nums[i-1] was added to its subarray.
        # prev_dp_sub: maximum total cost for nums[0...i-1], where nums[i-1] was subtracted from its subarray.

        # Base case for i = 0 (first element)
        # nums[0] must be added as it's the first element of its subarray.
        prev_dp_add = nums[0]
        # nums[0] cannot be subtracted from its subarray (as it's the first element).
        prev_dp_sub = -float('inf')

        for i in range(1, n):
            # Calculate current_dp_add for nums[i]:
            # nums[i] is added to its subarray. This can happen in two ways:
            # 1. nums[i] starts a new subarray. The cost before nums[i] is the maximum total cost achieved up to nums[i-1].
            #    This is max(prev_dp_add, prev_dp_sub). So, cost = max(prev_dp_add, prev_dp_sub) + nums[i].
            # 2. nums[i] extends an existing subarray where nums[i-1] was subtracted.
            #    So, cost = prev_dp_sub + nums[i].
            # We take the maximum of these two possibilities.
            # max(max(prev_dp_add, prev_dp_sub) + nums[i], prev_dp_sub + nums[i])
            # This simplifies to max(prev_dp_add, prev_dp_sub) + nums[i].
            current_dp_add = max(prev_dp_add, prev_dp_sub) + nums[i]

            # Calculate current_dp_sub for nums[i]:
            # nums[i] is subtracted from its subarray. This can only happen if:
            # 1. nums[i] extends an existing subarray where nums[i-1] was added.
            #    So, cost = prev_dp_add - nums[i].
            # nums[i] cannot start a new subarray and be subtracted.
            current_dp_sub = prev_dp_add - nums[i]

            # Update prev states for the next iteration
            prev_dp_add = current_dp_add
            prev_dp_sub = current_dp_sub

        # The final answer is the maximum total cost achieved up to the last element,
        # whether the last element was added or subtracted.
        return max(prev_dp_add, prev_dp_sub)