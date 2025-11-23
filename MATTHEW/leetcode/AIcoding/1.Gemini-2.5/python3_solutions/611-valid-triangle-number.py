class Solution:
    def triangleNumber(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        nums.sort()
        count = 0

        for k in range(n - 1, 1, -1):
            i = 0
            j = k - 1
            while i < j:
                if nums[i] + nums[j] > nums[k]:
                    # If nums[i] + nums[j] > nums[k], then for all elements
                    # nums[x] where i <= x < j, nums[x] + nums[j] > nums[k]
                    # will also be true because nums[x] >= nums[i] and nums[k] is fixed.
                    # This means all pairs (nums[x], nums[j]) for x from i to j-1
                    # form a valid triangle with nums[k].
                    count += (j - i)
                    j -= 1 # Try to find more pairs with a smaller second side
                else:
                    # nums[i] is too small, increment i to try a larger first side
                    i += 1
        return count