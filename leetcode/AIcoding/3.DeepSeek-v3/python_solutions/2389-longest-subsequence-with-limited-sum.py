class Solution:
    def answerQueries(self, nums: List[int], queries: List[int]) -> List[int]:
        nums.sort()
        prefix = [0]
        for num in nums:
            prefix.append(prefix[-1] + num)

        res = []
        for query in queries:
            idx = bisect.bisect_right(prefix, query) - 1
            res.append(idx)
        return res