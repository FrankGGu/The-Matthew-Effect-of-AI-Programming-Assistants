class Solution:
    def kLengthApart(self, nums: List[int], k: int) -> bool:
        last_index = -1
        for i in range(len(nums)):
            if nums[i] == 1:
                if last_index != -1 and i - last_index - 1 < k:
                    return False
                last_index = i
        return True