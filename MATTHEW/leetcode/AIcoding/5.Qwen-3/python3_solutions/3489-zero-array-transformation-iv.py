class Solution:
    def maxFinalValue(self, nums: List[int], original: int, energe: int) -> int:
        from collections import deque

        nums = deque(nums)
        while nums and nums[0] < original:
            nums.popleft()

        if not nums:
            return original

        count = 0
        while nums and nums[0] == original:
            nums.popleft()
            count += 1

        if count == 0:
            return original

        return original + (count - 1) * energe