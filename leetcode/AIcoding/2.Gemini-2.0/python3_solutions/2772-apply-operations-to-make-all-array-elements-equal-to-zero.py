class Solution:
    def checkArray(self, nums: list[int], k: int) -> bool:
        n = len(nums)
        diff = [0] * n
        curr = 0
        for i in range(n):
            curr += diff[i]
            if curr > nums[i]:
                return False
            diff_val = nums[i] - curr
            curr = nums[i]
            if i + k > n:
                return False
            if diff_val > 0:
                if i + k < n + 1:
                    diff[i] = diff_val
                    if i + k < n:
                        diff[i+k] -= diff_val
        return True