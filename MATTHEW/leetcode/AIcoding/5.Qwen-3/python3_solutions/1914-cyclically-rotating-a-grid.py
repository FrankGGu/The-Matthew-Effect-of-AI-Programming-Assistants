class Solution:
    def rotateGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        result = [row[:] for row in grid]

        def rotateLayer(layer):
            top = layer
            bottom = m - 1 - layer
            left = layer
            right = n - 1 - layer

            if top >= bottom or left >= right:
                return

            elements = []
            for i in range(left, right + 1):
                elements.append(grid[top][i])
            for i in range(top + 1, bottom + 1):
                elements.append(grid[i][right])
            for i in range(right - 1, left - 1, -1):
                elements.append(grid[bottom][i])
            for i in range(bottom - 1, top, -1):
                elements.append(grid[i][left])

            length = len(elements)
            k_mod = k % length
            elements = elements[-k_mod:] + elements[:-k_mod]

            index = 0
            for i in range(left, right + 1):
                result[top][i] = elements[index]
                index += 1
            for i in range(top + 1, bottom + 1):
                result[i][right] = elements[index]
                index += 1
            for i in range(right - 1, left - 1, -1):
                result[bottom][i] = elements[index]
                index += 1
            for i in range(bottom - 1, top, -1):
                result[i][left] = elements[index]
                index += 1

        for layer in range(min(m, n) // 2):
            rotateLayer(layer)

        return result