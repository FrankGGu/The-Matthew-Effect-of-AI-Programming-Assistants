class Solution:
    def getLongestSubsequence(self, nums: List[int], groups: List[int]) -> List[int]:
        res = []
        group_idx = 0
        for i in range(len(nums)):
            if group_idx < len(groups) and groups[group_idx] == groups[i]:
                res.append(nums[i])
                group_idx += 1
        return res