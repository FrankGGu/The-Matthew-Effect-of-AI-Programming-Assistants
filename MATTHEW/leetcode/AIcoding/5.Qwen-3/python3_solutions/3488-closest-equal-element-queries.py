class Solution:
    def closestEqual(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums)
        res = []
        for l, r in queries:
            min_dist = float('inf')
            for i in range(l, r + 1):
                for j in range(i + 1, r + 1):
                    if nums[i] == nums[j]:
                        min_dist = min(min_dist, j - i)
            if min_dist == float('inf'):
                res.append(-1)
            else:
                res.append(min_dist)
        return res