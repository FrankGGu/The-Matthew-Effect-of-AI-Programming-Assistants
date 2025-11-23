class Solution:
    def alternatingSubarray(self, nums: List[int]) -> int:
        max_len = -1
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                length = j - i + 1
                if length > 1:
                    valid = True
                    diff = nums[i+1] - nums[i]
                    if diff != 1:
                        valid = False
                    else:
                        for k in range(i, j):
                            expected_diff = 1 if (k - i) % 2 == 0 else -1
                            if nums[k+1] - nums[k] != expected_diff:
                                valid = False
                                break
                    if valid:
                        max_len = max(max_len, length)
        return max_len