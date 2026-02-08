class Solution:
    def maximumTop(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n == 1:
            if k % 2 == 0:
                return nums[0]
            else:
                return -1

        if k > n:
            return max(nums)

        if k == n:
            return max(nums[:-1])

        if k < n:
            max_val = -1
            for i in range(min(k - 1, n - 1)):
                max_val = max(max_val, nums[i])
            max_val = max(max_val, nums[k])
            return max_val