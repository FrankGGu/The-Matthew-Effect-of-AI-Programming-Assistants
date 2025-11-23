class Solution:
    def imageSmoother(self, img: list[list[int]]) -> list[list[int]]:
        m = len(img)
        n = len(img[0])
        result = [[0] * n for _ in range(m)]

        for r in range(m):
            for c in range(n):
                total_sum = 0
                count = 0
                for dr in range(-1, 2):
                    for dc in range(-1, 2):
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < m and 0 <= nc < n:
                            total_sum += img[nr][nc]
                            count += 1
                result[r][c] = total_sum // count

        return result