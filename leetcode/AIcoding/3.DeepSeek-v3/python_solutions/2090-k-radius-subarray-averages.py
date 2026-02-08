class Solution:
    def getAverages(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        res = [-1] * n
        window_size = 2 * k + 1
        if window_size > n:
            return res

        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        for i in range(k, n - k):
            res[i] = (prefix[i + k + 1] - prefix[i - k]) // window_size

        return res