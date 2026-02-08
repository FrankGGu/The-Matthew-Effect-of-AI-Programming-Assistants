class Solution:
    def floodFill(self, image: list[list[int]], sr: int, sc: int, newColor: int) -> list[list[int]]:
        R, C = len(image), len(image[0])
        original_color = image[sr][sc]

        if original_color == newColor:
            return image

        def dfs(r, c):
            if not (0 <= r < R and 0 <= c < C and image[r][c] == original_color):
                return

            image[r][c] = newColor

            dfs(r + 1, c)
            dfs(r - 1, c)
            dfs(r, c + 1)
            dfs(r, c - 1)

        dfs(sr, sc)
        return image