class Solution:
    def averageOfRegion(self, image: list[list[int]], threshold: int) -> list[list[int]]:
        m = len(image)
        n = len(image[0])

        result = [[image[r][c] for c in range(n)] for r in range(m)]

        for r in range(1, m - 1):
            for c in range(1, n - 1):
                is_valid_region = True

                for i in range(r - 1, r + 2):
                    for j in range(c - 1, c + 1):
                        if abs(image[i][j] - image[i][j+1]) > threshold:
                            is_valid_region = False
                            break
                    if not is_valid_region:
                        break

                if not is_valid_region:
                    continue

                for j in range(c - 1, c + 2):
                    for i in range(r - 1, r + 1):
                        if abs(image[i][j] - image[i+1][j]) > threshold:
                            is_valid_region = False
                            break
                    if not is_valid_region:
                        break

                if not is_valid_region:
                    continue

                current_region_sum = 0
                for i in range(r - 1, r + 2):
                    for j in range(c - 1, c + 2):
                        current_region_sum += image[i][j]

                avg = current_region_sum // 9

                for i in range(r - 1, r + 2):
                    for j in range(c - 1, c + 2):
                        result[i][j] = avg

        return result