class Solution:
    def longestObstacleCourseAtEachPosition(self, obstacles: List[int]) -> List[int]:
        import bisect
        res = []
        tails = []
        for num in obstacles:
            idx = bisect.bisect_right(tails, num)
            if idx == len(tails):
                tails.append(num)
            else:
                tails[idx] = num
            res.append(idx + 1)
        return res