class Solution:
    def maxSumOfThreeSubarrays(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)
        sums = [0] * (n - k + 1)
        for i in range(k):
            sums[0] += nums[i]
        for i in range(1, n - k + 1):
            sums[i] = sums[i - 1] - nums[i - 1] + nums[i + k - 1]

        left = [0] * (n - k + 1)
        max_index = 0
        for i in range(1, n - k + 1):
            if sums[i] > sums[max_index]:
                max_index = i
            left[i] = max_index

        right = [0] * (n - k + 1)
        max_index = n - k
        for i in range(n - k - 1, -1, -1):
            if sums[i] >= sums[max_index]:
                max_index = i
            right[i] = max_index

        ans = []
        max_sum = 0
        for j in range(k, n - 2 * k + 1):
            l = left[j - k]
            r = right[j + k]
            curr_sum = sums[l] + sums[j] + sums[r]
            if curr_sum > max_sum:
                max_sum = curr_sum
                ans = [l, j, r]

        return ans