class Solution:
    def kLengthApart(self, nums: list[int], k: int) -> bool:
        last = -1
        for i, num in enumerate(nums):
            if num == 1:
                if last != -1 and i - last - 1 < k:
                    return False
                last = i
        return True