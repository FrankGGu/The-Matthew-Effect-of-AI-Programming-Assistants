class Solution:
    def numSubseq(self, nums: list[int], target: int) -> int:
        nums.sort()
        n = len(nums)
        mod = 10**9 + 7

        ans = 0
        left = 0
        right = n - 1

        while left <= right:
            if nums[left] + nums[right] <= target:
                # If nums[left] is chosen as the minimum element of a subsequence,
                # and nums[right] is chosen as the maximum element,
                # then all elements between nums[left] and nums[right] (exclusive of left, inclusive of right)
                # can be included or excluded in the subsequence.
                # The number of such elements to choose from is (right - left).
                # Each choice, combined with nums[left], forms a valid subsequence
                # because nums[left] + nums[k] <= nums[left] + nums[right] <= target
                # for any k such that left <= k <= right.
                ans = (ans + pow(2, right - left, mod)) % mod
                left += 1
            else:
                # If nums[left] + nums[right] > target, then nums[right] is too large
                # to be the maximum element for a subsequence whose minimum is nums[left].
                # We must try a smaller maximum element, so decrement the right pointer.
                right -= 1

        return ans