class Solution:
    def minArea(self, image: List[str], x: int, y: int) -> int:
        top = bottom = x
        left = right = y

        for i in range(len(image)):
            for j in range(len(image[0])):
                if image[i][j] == '1':
                    top = min(top, i)
                    bottom = max(bottom, i)
                    left = min(left, j)
                    right = max(right, j)

        return (bottom - top + 1) * (right - left + 1)