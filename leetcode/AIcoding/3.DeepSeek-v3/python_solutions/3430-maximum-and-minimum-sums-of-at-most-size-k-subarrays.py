import collections

class Solution:
    def maximumSum(self, nums: List[int], k: int) -> int:
        max_sum = float('-inf')
        min_sum = float('inf')
        prefix = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix[i+1] = prefix[i] + nums[i]

        dq = collections.deque()
        for i in range(len(prefix)):
            while dq and prefix[i] <= prefix[dq[-1]]:
                dq.pop()
            while dq and i - dq[0] > k:
                dq.popleft()
            dq.append(i)
            if i >= 1:
                current_sum = prefix[i] - prefix[dq[0]]
                max_sum = max(max_sum, current_sum)
                min_sum = min(min_sum, current_sum)

        return max_sum if k == len(nums) else max_sum - min_sum