class Solution:
    def alternatingSubarray(self, nums: List[int]) -> int:
        max_len = -1
        n = len(nums)
        for i in range(n - 1):
            if nums[i + 1] - nums[i] == 1:
                current_len = 2
                for j in range(i + 2, n):
                    if nums[j] == nums[j - 2]:
                        current_len += 1
                    else:
                        break
                if current_len > max_len:
                    max_len = current_len
        return max_len