class Solution:
    def longestEvenOddSubarray(self, nums: List[int], threshold: int) -> int:
        max_len = 0
        curr_len = 0
        for num in nums:
            if num <= threshold:
                if curr_len == 0:
                    if num % 2 == 0:
                        curr_len = 1
                    else:
                        continue
                else:
                    if (num % 2) != (nums[nums.index(num) - curr_len] % 2):
                        curr_len += 1
                    else:
                        if num % 2 == 0:
                            curr_len = 1
                        else:
                            curr_len = 0
            else:
                curr_len = 0
            max_len = max(max_len, curr_len)
        return max_len