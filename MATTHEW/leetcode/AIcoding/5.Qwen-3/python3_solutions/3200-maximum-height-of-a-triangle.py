class Solution:
    def maxHeightOfTriangle(self, red: int, blue: int) -> int:
        def max_height(r, b):
            height = 0
            while True:
                height += 1
                if height % 2 == 1:
                    r -= height
                else:
                    b -= height
                if r < 0 or b < 0:
                    return height - 1
        return max(max_height(red, blue), max_height(blue, red))