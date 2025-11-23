class Solution:
    def longestObstacleCourseAtEachPosition(self, obstacles: List[int]) -> List[int]:
        import bisect
        res = []
        tails = []
        for ob in obstacles:
            idx = bisect.bisect_right(tails, ob)
            if idx == len(tails):
                tails.append(ob)
            else:
                tails[idx] = ob
            res.append(idx + 1)
        return res