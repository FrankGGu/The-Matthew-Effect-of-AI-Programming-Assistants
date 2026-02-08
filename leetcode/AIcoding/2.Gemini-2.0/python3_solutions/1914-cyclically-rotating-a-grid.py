class Solution:
    def rotateGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        layers = min(m, n) // 2

        for layer in range(layers):
            elements = []

            for j in range(layer, n - layer - 1):
                elements.append(grid[layer][j])
            for i in range(layer, m - layer - 1):
                elements.append(grid[i][n - layer - 1])
            for j in range(n - layer - 1, layer, -1):
                elements.append(grid[m - layer - 1][j])
            for i in range(m - layer - 1, layer, -1):
                elements.append(grid[i][layer])

            l = len(elements)
            rotations = k % l
            rotated_elements = elements[-rotations:] + elements[:-rotations]

            index = 0

            for j in range(layer, n - layer - 1):
                grid[layer][j] = rotated_elements[index]
                index += 1
            for i in range(layer, m - layer - 1):
                grid[i][n - layer - 1] = rotated_elements[index]
                index += 1
            for j in range(n - layer - 1, layer, -1):
                grid[m - layer - 1][j] = rotated_elements[index]
                index += 1
            for i in range(m - layer - 1, layer, -1):
                grid[i][layer] = rotated_elements[index]
                index += 1

        return grid