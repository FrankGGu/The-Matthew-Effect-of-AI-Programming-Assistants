import collections

class Solution:
    def shortestSubarray(self, nums: list[int], k: int) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        min_len = float('inf')

        dq = collections.deque() 

        for i in range(n + 1):
            while dq and prefix_sum[i] - prefix_sum[dq[0]] >= k:
                min_len = min(min_len, i - dq.popleft())

            while dq and prefix_sum[i] <= prefix_sum[dq[-1]]:
                dq.pop()

            dq.append(i)

        return min_len if min_len != float('inf') else -1