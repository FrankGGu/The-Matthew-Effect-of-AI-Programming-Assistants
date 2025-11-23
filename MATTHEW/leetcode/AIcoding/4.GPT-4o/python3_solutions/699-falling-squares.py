class Solution:
    def fallingSquares(self, positions: List[List[int]]) -> List[int]:
        end_points = []
        heights = []
        max_height = 0

        for left, size in positions:
            right = left + size
            curr_height = 0

            for i in range(len(end_points)):
                if left < end_points[i][1] and right > end_points[i][0]:
                    curr_height = max(curr_height, end_points[i][2])

            curr_height += size
            max_height = max(max_height, curr_height)
            end_points.append([left, right, curr_height])
            heights.append(max_height)

        return heights