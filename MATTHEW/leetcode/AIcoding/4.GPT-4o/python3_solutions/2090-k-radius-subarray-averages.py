class Solution:
    def getAverages(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        result = [-1] * n
        if n < 2 * k + 1:
            return result

        window_sum = sum(nums[:2 * k + 1])
        result[k] = window_sum // (2 * k + 1)

        for i in range(1, n - 2 * k):
            window_sum = window_sum - nums[i - 1] + nums[i + 2 * k]
            result[i + k] = window_sum // (2 * k + 1)

        return result