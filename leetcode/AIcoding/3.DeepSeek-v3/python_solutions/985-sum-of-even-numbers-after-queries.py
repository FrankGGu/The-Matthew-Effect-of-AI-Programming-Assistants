class Solution:
    def sumEvenAfterQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        S = sum(x for x in nums if x % 2 == 0)
        res = []
        for val, idx in queries:
            if nums[idx] % 2 == 0:
                S -= nums[idx]
            nums[idx] += val
            if nums[idx] % 2 == 0:
                S += nums[idx]
            res.append(S)
        return res