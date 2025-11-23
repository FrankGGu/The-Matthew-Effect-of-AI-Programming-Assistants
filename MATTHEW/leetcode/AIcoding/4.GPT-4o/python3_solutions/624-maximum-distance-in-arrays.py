class Solution:
    def maxDistance(self, arrays: List[List[int]]) -> int:
        min1, max1 = arrays[0][0], arrays[0][-1]
        max_distance = 0

        for i in range(1, len(arrays)):
            max_distance = max(max_distance, abs(arrays[i][0] - max1), abs(arrays[i][-1] - min1))
            min1 = min(min1, arrays[i][0])
            max1 = max(max1, arrays[i][-1])

        return max_distance