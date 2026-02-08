class Solution:
    def getXSum(self, nums: List[int], k: int, x: int) -> int:
        from collections import deque

        n = len(nums)
        if n < k:
            return 0

        max_deque = deque()
        min_deque = deque()
        res = 0

        for i in range(n):
            # Remove elements out of the current window from the front of the deque
            while max_deque and max_deque[0] < i - k + 1:
                max_deque.popleft()
            while min_deque and min_deque[0] < i - k + 1:
                min_deque.popleft()

            # Maintain the max deque in decreasing order
            while max_deque and nums[max_deque[-1]] <= nums[i]:
                max_deque.pop()
            max_deque.append(i)

            # Maintain the min deque in increasing order
            while min_deque and nums[min_deque[-1]] >= nums[i]:
                min_deque.pop()
            min_deque.append(i)

            # Once the window is of size k, start adding to the result
            if i >= k - 1:
                res += nums[max_deque[0]] + nums[min_deque[0]]

        return res % x