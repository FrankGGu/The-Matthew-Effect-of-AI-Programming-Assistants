class Solution:
    def maxSumOfThreeSubarrays(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)

        W = [0] * (n - k + 1)
        current_sum = 0
        for i in range(n):
            current_sum += nums[i]
            if i >= k:
                current_sum -= nums[i - k]
            if i >= k - 1:
                W[i - k + 1] = current_sum

        m = len(W)

        left = [0] * m
        left[0] = 0
        for i in range(1, m):
            if W[i] > W[left[i-1]]:
                left[i] = i
            else:
                left[i] = left[i-1]

        right = [0] * m
        right[m-1] = m-1
        for i in range(m - 2, -1, -1):
            if W[i] >= W[right[i+1]]:
                right[i] = i
            else:
                right[i] = right[i+1]

        max_total_sum = -1
        ans = []

        for j in range(k, m - k):
            i = left[j - k]
            l = right[j + k]

            current_total_sum = W[i] + W[j] + W[l]

            if current_total_sum > max_total_sum:
                max_total_sum = current_total_sum
                ans = [i, j, l]

        return ans