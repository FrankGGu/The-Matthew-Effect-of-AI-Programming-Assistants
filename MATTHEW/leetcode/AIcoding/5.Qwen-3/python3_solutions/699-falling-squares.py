class Solution:
    def fallingSquares(self, intervals):
        res = []
        starts = []
        ends = []
        heights = []
        for start, end in intervals:
            height = 0
            for i in range(len(starts)):
                if starts[i] < end and ends[i] > start:
                    height = max(height, heights[i])
            res.append(height + end - start)
            starts.append(start)
            ends.append(end)
            heights.append(height + end - start)
        return res