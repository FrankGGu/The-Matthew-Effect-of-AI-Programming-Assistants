import collections

class Solution:
    def longestSubarray(self, nums: list[int], limit: int) -> int:
        min_deque = collections.deque()
        max_deque = collections.deque()

        left = 0
        max_len = 0

        for right in range(len(nums)):
            while max_deque and nums[max_deque[-1]] <= nums[right]:
                max_deque.pop()
            max_deque.append(right)

            while min_deque and nums[min_deque[-1]] >= nums[right]:
                min_deque.pop()
            min_deque.append(right)

            while nums[max_deque[0]] - nums[min_deque[0]] > limit:
                left += 1
                if max_deque[0] < left:
                    max_deque.popleft()
                if min_deque[0] < left:
                    min_deque.popleft()

            max_len = max(max_len, right - left + 1)

        return max_len