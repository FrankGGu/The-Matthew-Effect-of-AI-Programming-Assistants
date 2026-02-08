class Solution:
    def alternatingColors(self, colors: List[int]) -> int:
        count = 0
        prev = None

        for color in colors:
            if color != prev:
                count += 1
                prev = color

        return count