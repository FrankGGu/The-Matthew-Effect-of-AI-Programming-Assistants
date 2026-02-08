from collections import deque

class Solution:
    def maxSlidingWindow(self, nums: list[int], k: int) -> list[int]:
        if not nums:
            return []

        result = []
        window = deque()

        for i in range(len(nums)):
            while window and nums[window[-1]] <= nums[i]:
                window.pop()

            window.append(i)

            if window[0] <= i - k:
                window.popleft()

            if i >= k - 1:
                result.append(nums[window[0]])

        return result