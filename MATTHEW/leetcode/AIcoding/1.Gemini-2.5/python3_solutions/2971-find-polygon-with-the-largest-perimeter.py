class Solution:
    def largestPerimeter(self, nums: list[int]) -> int:
        nums.sort()

        current_sum = sum(nums)

        # Iterate from the largest possible number of sides down to 3.
        # 'i' represents the index of the largest side in the current set of sides being considered.
        # The set of sides is nums[0]...nums[i].
        # A polygon must have at least 3 sides, so 'i' must be at least 2.
        for i in range(len(nums) - 1, 1, -1):
            # The sum of the (i) smallest sides (excluding nums[i]) is current_sum - nums[i].
            # The largest side in the current set is nums[i].
            # For a polygon to be formed, the sum of all sides except the largest must be strictly greater than the largest side.
            if current_sum - nums[i] > nums[i]:
                # If the condition is met, a polygon can be formed with sides nums[0]...nums[i].
                # Since we are iterating from the largest possible number of sides downwards,
                # the first perimeter we find that satisfies the condition will be the largest.
                return current_sum

            # If a polygon cannot be formed with nums[0]...nums[i],
            # we remove nums[i] from consideration and try with a smaller set of sides (nums[0]...nums[i-1]).
            current_sum -= nums[i]

        # If the loop completes, it means no polygon with at least 3 sides can be formed.
        return -1