class Solution:
    def rotateGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        layers = min(m, n) // 2

        for layer in range(layers):
            elements = []
            # Top row (left to right)
            for j in range(layer, n - layer - 1):
                elements.append(grid[layer][j])
            # Right column (top to bottom)
            for i in range(layer, m - layer - 1):
                elements.append(grid[i][n - layer - 1])
            # Bottom row (right to left)
            for j in range(n - layer - 1, layer, -1):
                elements.append(grid[m - layer - 1][j])
            # Left column (bottom to top)
            for i in range(m - layer - 1, layer, -1):
                elements.append(grid[i][layer])

            if not elements:
                continue

            total = len(elements)
            rotate = k % total
            rotated_elements = elements[rotate:] + elements[:rotate]

            index = 0
            # Top row (left to right)
            for j in range(layer, n - layer - 1):
                grid[layer][j] = rotated_elements[index]
                index += 1
            # Right column (top to bottom)
            for i in range(layer, m - layer - 1):
                grid[i][n - layer - 1] = rotated_elements[index]
                index += 1
            # Bottom row (right to left)
            for j in range(n - layer - 1, layer, -1):
                grid[m - layer - 1][j] = rotated_elements[index]
                index += 1
            # Left column (bottom to top)
            for i in range(m - layer - 1, layer, -1):
                grid[i][layer] = rotated_elements[index]
                index += 1

        return grid