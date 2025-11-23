class Solution:
    def longestAlternatingSubarray(self, nums: List[int], threshold: int) -> int:
        max_len = 0
        for i in range(len(nums)):
            if nums[i] > threshold:
                continue
            curr_len = 1
            if nums[i] % 2 == 0:
                max_len = max(max_len, curr_len)
                for j in range(i + 1, len(nums)):
                    if nums[j] > threshold:
                        break
                    if nums[j] % 2 != nums[j - 1] % 2:
                        curr_len += 1
                        max_len = max(max_len, curr_len)
                    else:
                        break

        return max_len