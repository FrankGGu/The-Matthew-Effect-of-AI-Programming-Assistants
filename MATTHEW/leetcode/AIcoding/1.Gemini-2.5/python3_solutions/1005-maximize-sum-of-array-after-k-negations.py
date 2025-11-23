class Solution:
    def largestSumAfterKNegations(self, nums: list[int], k: int) -> int:
        nums.sort()

        # Phase 1: Negate negative numbers
        # Iterate through the sorted array and negate negative numbers as long as k > 0.
        # This greedily maximizes the sum by turning negative numbers into positive ones.
        for i in range(len(nums)):
            if nums[i] < 0 and k > 0:
                nums[i] = -nums[i]
                k -= 1
            # Optimization: If current number is non-negative and k is 0,
            # no more negations are needed for negative numbers, and
            # since the array is sorted, all subsequent numbers will also be non-negative.
            # So, we can break early.
            elif nums[i] >= 0 and k == 0:
                break
            # If nums[i] is non-negative but k > 0, we continue the loop.
            # This case is actually covered by the break above due to sorting.
            # If nums[i] is non-negative, all subsequent elements are also non-negative,
            # so we would have broken. This `elif` effectively acts as a `break` for the rest of the array.

        # Phase 2: Handle remaining k (if any)
        # After negating all possible negative numbers, if k is still positive:
        # If k is even, it means we can perform k/2 pairs of negations on any number,
        # effectively cancelling each other out (e.g., x -> -x -> x). The sum remains unchanged.
        # If k is odd, we must perform one more negation. To maximize the sum,
        # we should choose the number with the smallest absolute value to negate.
        # This will result in the smallest possible decrease in the total sum.
        if k % 2 == 1:
            # Re-sort the array to find the smallest element.
            # This is necessary because negating numbers in Phase 1 might change their relative order.
            # For example, [-5, -1, 2] with k=2 becomes [5, 1, 2].
            # If k was 3, after Phase 1, it's [5, 1, 2] with k=1.
            # We then need to find the smallest element in [5, 1, 2], which is 1, and negate it.
            nums.sort()
            nums[0] = -nums[0]

        return sum(nums)