import collections

class Solution:
    def shortestSubarray(self, nums: list[int], k: int) -> int:
        n = len(nums)
        prefix_sums = [0] * (n + 1)
        for i in range(n):
            prefix_sums[i + 1] = prefix_sums[i] + nums[i]

        min_len = float('inf')
        deque = collections.deque()
        for i in range(n + 1):
            while deque and prefix_sums[i] - prefix_sums[deque[0]] >= k:
                min_len = min(min_len, i - deque.popleft())
            while deque and prefix_sums[i] <= prefix_sums[deque[-1]]:
                deque.pop()
            deque.append(i)

        return min_len if min_len != float('inf') else -1