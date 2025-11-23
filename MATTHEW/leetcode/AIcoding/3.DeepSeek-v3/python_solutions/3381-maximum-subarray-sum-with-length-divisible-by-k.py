class Solution:
    def maxSubarraySumCircular(self, nums: List[int], k: int) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        max_sum = -float('inf')
        from collections import deque
        dq = deque()
        dq.append(0)

        for j in range(1, n + 1):
            while dq and j - dq[0] > k:
                dq.popleft()
            if dq:
                current_sum = prefix_sum[j] - prefix_sum[dq[0]]
                if current_sum > max_sum and (j - dq[0]) % k == 0:
                    max_sum = current_sum
            while dq and prefix_sum[j] <= prefix_sum[dq[-1]]:
                dq.pop()
            dq.append(j)

        return max_sum if max_sum != -float('inf') else 0