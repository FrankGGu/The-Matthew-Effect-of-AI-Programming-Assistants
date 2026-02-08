import collections

class Solution:
    def minLengthAfterRemovals(self, nums: list[int]) -> int:
        n = len(nums)
        nums.sort()

        pairs = 0
        left = 0
        right = n // 2

        while left < n // 2 and right < n:
            if nums[left] < nums[right]:
                pairs += 1
                left += 1
                right += 1
            else:
                # nums[left] >= nums[right]
                # nums[right] is too small to be paired with nums[left].
                # Since nums is sorted, nums[right] also cannot be paired with
                # any nums[k] where k > left (as nums[k] >= nums[left] >= nums[right]).
                # So, nums[right] cannot be the larger element in any pair with
                # nums[left] or any element to its right.
                # We need to find a larger element for nums[left], so we advance right.
                right += 1

        return n - 2 * pairs