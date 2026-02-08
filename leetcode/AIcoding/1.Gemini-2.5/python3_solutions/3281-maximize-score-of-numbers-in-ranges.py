class Solution:
    def maximumScore(self, nums: list[int], k: int) -> int:
        n = len(nums)
        left = k
        right = k
        min_val = nums[k]
        max_score = nums[k]

        while left > 0 or right < n - 1:
            if left == 0:
                right += 1
                min_val = min(min_val, nums[right])
            elif right == n - 1:
                left -= 1
                min_val = min(min_val, nums[left])
            else:
                if nums[left - 1] > nums[right + 1]:
                    left -= 1
                    min_val = min(min_val, nums[left])
                else:
                    right += 1
                    min_val = min(min_val, nums[right])

            max_score = max(max_score, min_val * (right - left + 1))

        return max_score