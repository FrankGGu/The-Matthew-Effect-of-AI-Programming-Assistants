from collections import deque

class Solution:
    def findXSum(self, nums: list[int], k: int) -> int:
        n = len(nums)
        if n == 0 or k == 0 or k > n:
            return 0

        min_dq = deque()
        max_dq = deque()
        total_x_sum = 0

        for i in range(n):
            if min_dq and min_dq[0] == i - k:
                min_dq.popleft()
            if max_dq and max_dq[0] == i - k:
                max_dq.popleft()

            while min_dq and nums[min_dq[-1]] >= nums[i]:
                min_dq.pop()
            min_dq.append(i)

            while max_dq and nums[max_dq[-1]] <= nums[i]:
                max_dq.pop()
            max_dq.append(i)

            if i >= k - 1:
                current_min = nums[min_dq[0]]
                current_max = nums[max_dq[0]]
                total_x_sum += (current_min + current_max)

        return total_x_sum