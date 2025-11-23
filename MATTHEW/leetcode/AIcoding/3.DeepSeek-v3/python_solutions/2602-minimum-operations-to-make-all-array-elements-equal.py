class Solution:
    def minOperations(self, nums: List[int], queries: List[int]) -> List[int]:
        nums.sort()
        prefix = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix[i+1] = prefix[i] + nums[i]

        res = []
        for q in queries:
            idx = bisect.bisect_left(nums, q)
            left_sum = q * idx - prefix[idx]
            right_sum = (prefix[-1] - prefix[idx]) - q * (len(nums) - idx)
            res.append(left_sum + right_sum)
        return res