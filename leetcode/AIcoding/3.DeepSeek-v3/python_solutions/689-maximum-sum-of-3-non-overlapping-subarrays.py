class Solution:
    def maxSumOfThreeSubarrays(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        left = [0] * n
        max_sum = prefix[k] - prefix[0]
        for i in range(k, n):
            current = prefix[i + 1] - prefix[i + 1 - k]
            if current > max_sum:
                max_sum = current
                left[i] = i + 1 - k
            else:
                left[i] = left[i - 1]

        right = [0] * n
        max_sum = prefix[n] - prefix[n - k]
        right[n - k] = n - k
        for i in range(n - k - 1, -1, -1):
            current = prefix[i + k] - prefix[i]
            if current >= max_sum:
                max_sum = current
                right[i] = i
            else:
                right[i] = right[i + 1]

        max_total = 0
        res = [0, 0, 0]
        for i in range(k, n - 2 * k + 1):
            l = left[i - 1]
            r = right[i + k]
            total = (prefix[l + k] - prefix[l]) + (prefix[i + k] - prefix[i]) + (prefix[r + k] - prefix[r])
            if total > max_total:
                max_total = total
                res = [l, i, r]
        return res