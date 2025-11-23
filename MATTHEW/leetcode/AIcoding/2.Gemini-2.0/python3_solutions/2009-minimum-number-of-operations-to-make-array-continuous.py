class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        unique_nums = sorted(list(set(nums)))
        unique_len = len(unique_nums)

        ans = n
        j = 0
        for i in range(unique_len):
            while j < unique_len and unique_nums[j] < unique_nums[i] + n:
                j += 1

            count = j - i
            ans = min(ans, n - count)

        return ans