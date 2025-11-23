import collections

class Solution:
    def constrainedSubsetSum(self, nums: List[int], k: int) -> int:
        dq = collections.deque()
        res = float('-inf')

        for i in range(len(nums)):
            if dq and dq[0] == i - k - 1:
                dq.popleft()

            curr = nums[i] + (dq and nums[dq[0]] or 0)
            nums[i] = max(nums[i], curr)

            while dq and nums[i] >= nums[dq[-1]]:
                dq.pop()

            dq.append(i)
            res = max(res, nums[i])

        return res