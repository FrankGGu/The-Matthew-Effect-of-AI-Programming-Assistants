from collections import deque

class Solution:
    def longestSubarray(self, nums: list[int], limit: int) -> int:
        min_deque = deque()
        max_deque = deque()
        left = 0
        max_len = 0
        for right, num in enumerate(nums):
            while min_deque and nums[min_deque[-1]] > num:
                min_deque.pop()
            min_deque.append(right)

            while max_deque and nums[max_deque[-1]] < num:
                max_deque.pop()
            max_deque.append(right)

            while nums[max_deque[0]] - nums[min_deque[0]] > limit:
                if max_deque[0] == left:
                    max_deque.popleft()
                if min_deque[0] == left:
                    min_deque.popleft()
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len