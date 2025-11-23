class Solution:
    def queryResults(self, limit: int, queries: List[List[int]]) -> List[int]:
        ball_to_color = {}
        color_count = {}
        res = []

        for ball, color in queries:
            if ball in ball_to_color:
                old_color = ball_to_color[ball]
                color_count[old_color] -= 1
                if color_count[old_color] == 0:
                    del color_count[old_color]

            ball_to_color[ball] = color
            color_count[color] = color_count.get(color, 0) + 1

            res.append(len(color_count))

        return res