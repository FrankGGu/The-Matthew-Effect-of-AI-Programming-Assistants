class Solution:
    def minArea(self, image: List[str], x: int, y: int) -> int:
        left = right = y
        top = bottom = x

        for i in range(len(image)):
            for j in range(len(image[0])):
                if image[i][j] == '1':
                    left = min(left, j)
                    right = max(right, j)
                    top = min(top, i)
                    bottom = max(bottom, i)

        return (right - left + 1) * (bottom - top + 1)