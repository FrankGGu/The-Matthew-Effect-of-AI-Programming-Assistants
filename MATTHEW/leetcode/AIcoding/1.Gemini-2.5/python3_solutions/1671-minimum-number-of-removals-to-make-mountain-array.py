class Solution:
    def minimumMountainRemovals(self, nums: list[int]) -> int:
        n = len(nums)

        # dp_inc[i] stores the length of the longest increasing subsequence ending at index i
        dp_inc = [1] * n
        for i in range(n):
            for j in range(i):
                if nums[i] > nums[j]:
                    dp_inc[i] = max(dp_inc[i], dp_inc[j] + 1)

        # dp_dec[i] stores the length of the longest decreasing subsequence starting at index i
        dp_dec = [1] * n
        for i in range(n - 1, -1, -1):
            for j in range(n - 1, i, -1):
                if nums[i] > nums[j]:
                    dp_dec[i] = max(dp_dec[i], dp_dec[j] + 1)

        max_mountain_len = 0
        for i in range(n):
            # For nums[i] to be a peak, it must have a strictly increasing part before it
            # and a strictly decreasing part after it.
            # This means dp_inc[i] must be at least 2 (meaning there's at least one element smaller before it)
            # and dp_dec[i] must be at least 2 (meaning there's at least one element smaller after it)
            if dp_inc[i] >= 2 and dp_dec[i] >= 2:
                # The length of the mountain array with peak at i is dp_inc[i] + dp_dec[i] - 1
                # (subtract 1 because nums[i] is counted in both dp_inc[i] and dp_dec[i])
                max_mountain_len = max(max_mountain_len, dp_inc[i] + dp_dec[i] - 1)

        # The minimum number of removals is the total number of elements minus the length
        # of the longest mountain subarray found.
        return n - max_mountain_len