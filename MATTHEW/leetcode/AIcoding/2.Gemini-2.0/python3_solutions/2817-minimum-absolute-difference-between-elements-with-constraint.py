class Solution:
    def minAbsoluteDifference(self, nums: List[int], x: int) -> int:
        n = len(nums)
        ans = float('inf')
        s = set()
        for i in range(x, n):
            s.add(nums[i - x])
            it = bisect.bisect_left(sorted(s), nums[i])
            arr = sorted(s)
            if it < len(arr):
                ans = min(ans, abs(nums[i] - arr[it]))
            if it > 0:
                ans = min(ans, abs(nums[i] - arr[it - 1]))
        return ans