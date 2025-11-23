class Solution:
    def maxSumOfThreeSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        def get_sum(i, j):
            return prefix[j] - prefix[i]

        left = [0] * n
        max_idx = 0
        for i in range(k - 1, n):
            if get_sum(i - k + 1, i + 1) > get_sum(max_idx, max_idx + k):
                max_idx = i - k + 1
            left[i] = max_idx

        right = [0] * n
        max_idx = n - 1
        for i in range(n - k, -1, -1):
            if get_sum(i, i + k) > get_sum(max_idx, max_idx + k):
                max_idx = i
            right[i] = max_idx

        res = 0
        res_idx = 0
        for i in range(k, n - k + 1):
            l = left[i - 1]
            r = right[i + k]
            current = get_sum(l, l + k) + get_sum(i, i + k) + get_sum(r, r + k)
            if current > res:
                res = current
                res_idx = l
        return res_idx