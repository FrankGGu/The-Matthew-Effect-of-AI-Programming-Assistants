class Solution:
    def maximumScore(self, nums: List[int], k: int) -> int:
        left = right = k
        res = min_val = nums[k]
        n = len(nums)

        while left > 0 or right < n - 1:
            if left == 0:
                right += 1
            elif right == n - 1:
                left -= 1
            elif nums[left - 1] > nums[right + 1]:
                left -= 1
            else:
                right += 1
            min_val = min(min_val, nums[left], nums[right])
            res = max(res, min_val * (right - left + 1))

        return res