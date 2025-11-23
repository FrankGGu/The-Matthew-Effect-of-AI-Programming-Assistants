class Solution:
    def countPoints(self, rings: str) -> int:
        color_map = {}
        for i in range(0, len(rings), 2):
            color = rings[i]
            rod = rings[i+1]
            if rod not in color_map:
                color_map[rod] = set()
            color_map[rod].add(color)
        return sum(1 for colors in color_map.values() if len(colors) == 3)