import collections

class Solution:
    def maxSlidingWindow(self, nums: list[int], k: int) -> list[int]:
        dq = collections.deque()
        result = []

        for i in range(len(nums)):
            # Remove elements from the front of the deque if they are outside the current window
            if dq and dq[0] == i - k:
                dq.popleft()

            # Remove elements from the back of the deque if they are smaller than the current element
            # This maintains the deque in decreasing order
            while dq and nums[dq[-1]] <= nums[i]:
                dq.pop()

            # Add the current element's index to the back of the deque
            dq.append(i)

            # If the window has fully formed, the front of the deque contains the index of the maximum element
            if i >= k - 1:
                result.append(nums[dq[0]])

        return result