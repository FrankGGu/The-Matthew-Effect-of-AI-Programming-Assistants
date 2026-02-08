class Solution:
    def resultGrid(self, image: list[list[int]], threshold: int) -> list[list[int]]:
        m, n = len(image), len(image[0])
        regions = {}
        for i in range(m - 2):
            for j in range(n - 2):
                avg = sum(image[x][y] for x in range(i, i + 3) for y in range(j, j + 3)) / 9
                valid = True
                for x in range(i, i + 3):
                    for y in range(j, j + 2):
                        if abs(image[x][y] - image[x][y + 1]) > threshold:
                            valid = False
                            break
                    if not valid:
                        break
                if valid:
                    for x in range(i, i + 2):
                        for y in range(j, j + 3):
                            if abs(image[x][y] - image[x + 1][y]) > threshold:
                                valid = False
                                break
                        if not valid:
                            break
                if valid:
                    for x in range(i, i + 3):
                        for y in range(j, j + 3):
                            if (x, y) not in regions:
                                regions[(x, y)] = []
                            regions[(x, y)].append(avg)

        result = [[-1] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                if (i, j) in regions:
                    result[i][j] = int(sum(regions[(i, j)]) / len(regions[(i, j)]))
                else:
                    result[i][j] = image[i][j]

        return result