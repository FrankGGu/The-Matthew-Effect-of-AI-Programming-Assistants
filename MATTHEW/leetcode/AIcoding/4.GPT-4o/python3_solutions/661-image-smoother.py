class Solution:
    def imageSmoother(self, img: List[List[int]]) -> List[List[int]]:
        rows, cols = len(img), len(img[0])
        result = [[0] * cols for _ in range(rows)]

        for i in range(rows):
            for j in range(cols):
                total = 0
                count = 0
                for a in range(max(0, i - 1), min(rows, i + 2)):
                    for b in range(max(0, j - 1), min(cols, j + 2)):
                        total += img[a][b]
                        count += 1
                result[i][j] = total // count

        return result