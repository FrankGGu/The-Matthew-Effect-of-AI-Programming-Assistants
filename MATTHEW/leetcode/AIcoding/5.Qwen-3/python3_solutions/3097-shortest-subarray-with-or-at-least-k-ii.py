from collections import deque
from typing import List

class Solution:
    def minimumSubarrayLengths(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        result = [-1] * n
        dq = deque()

        for i in range(n):
            while dq and nums[dq[-1]] > nums[i]:
                dq.pop()
            dq.append(i)

            while dq and nums[dq[0]] < nums[i]:
                dq.popleft()

            if dq[0] <= i - 1:
                result[i] = i - dq[0]
            else:
                result[i] = -1

        return result