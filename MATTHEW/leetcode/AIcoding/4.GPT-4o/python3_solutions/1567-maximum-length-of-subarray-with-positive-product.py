class Solution:
    def getMaxLen(self, nums: List[int]) -> int:
        max_len = 0
        current_len = 0
        last_negative_index = -1
        first_negative_index = -1

        for i, num in enumerate(nums):
            if num > 0:
                current_len += 1
            elif num < 0:
                current_len += 1
                if first_negative_index == -1:
                    first_negative_index = i
                else:
                    last_negative_index = first_negative_index
                    first_negative_index = i
                if last_negative_index != -1:
                    max_len = max(max_len, current_len - (last_negative_index + 1))
                else:
                    max_len = max(max_len, current_len)
            else:
                current_len = 0
                first_negative_index = -1
                last_negative_index = -1

        return max(max_len, current_len) if current_len > 0 else max_len