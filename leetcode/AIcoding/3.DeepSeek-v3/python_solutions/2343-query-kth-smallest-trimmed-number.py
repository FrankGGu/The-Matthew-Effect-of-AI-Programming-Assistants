class Solution:
    def smallestTrimmedNumbers(self, nums: List[str], queries: List[List[int]]) -> List[int]:
        res = []
        for k, trim in queries:
            trimmed = [(num[-trim:], i) for i, num in enumerate(nums)]
            trimmed.sort()
            res.append(trimmed[k-1][1])
        return res