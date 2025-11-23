import collections

class Solution:
    def longestSubarray(self, nums: List[int], limit: int) -> int:
        min_deque = collections.deque()
        max_deque = collections.deque()
        left = 0
        max_len = 0

        for right, num in enumerate(nums):
            while min_deque and num < min_deque[-1]:
                min_deque.pop()
            min_deque.append(num)

            while max_deque and num > max_deque[-1]:
                max_deque.pop()
            max_deque.append(num)

            while max_deque[0] - min_deque[0] > limit:
                if nums[left] == min_deque[0]:
                    min_deque.popleft()
                if nums[left] == max_deque[0]:
                    max_deque.popleft()
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len