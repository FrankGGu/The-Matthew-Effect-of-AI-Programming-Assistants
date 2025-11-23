class Solution:
    def goodIndices(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)

        left_non_increasing_len = [1] * n
        for j in range(1, n):
            if nums[j-1] >= nums[j]:
                left_non_increasing_len[j] = left_non_increasing_len[j-1] + 1
            else:
                left_non_increasing_len[j] = 1

        right_non_decreasing_len = [1] * n
        for j in range(n - 2, -1, -1):
            if nums[j] <= nums[j+1]:
                right_non_decreasing_len[j] = right_non_decreasing_len[j+1] + 1
            else:
                right_non_decreasing_len[j] = 1

        ans = []
        for i in range(k, n - k):
            condition1 = left_non_increasing_len[i-1] >= k
            condition2 = right_non_decreasing_len[i+1] >= k

            if condition1 and condition2:
                ans.append(i)

        return ans