class Solution:
    def maxDistance(self, arrays: list[list[int]]) -> int:
        max_dist = 0

        min_so_far = arrays[0][0]
        max_so_far = arrays[0][-1]

        for i in range(1, len(arrays)):
            current_min = arrays[i][0]
            current_max = arrays[i][-1]

            max_dist = max(max_dist, 
                           abs(current_max - min_so_far), 
                           abs(max_so_far - current_min))

            min_so_far = min(min_so_far, current_min)
            max_so_far = max(max_so_far, current_max)

        return max_dist