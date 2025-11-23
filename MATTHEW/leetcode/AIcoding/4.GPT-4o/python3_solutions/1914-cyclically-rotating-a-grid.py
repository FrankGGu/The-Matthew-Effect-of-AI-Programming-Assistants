def rotateGrid(grid: List[List[int]], k: int) -> List[List[int]]:
    rows, cols = len(grid), len(grid[0])
    layers = min(rows, cols) // 2
    for layer in range(layers):
        elements = []
        for i in range(layer, rows - layer):
            elements.append(grid[i][layer])
        for i in range(layer + 1, cols - layer):
            elements.append(grid[rows - layer - 1][i])
        for i in range(rows - layer - 2, layer - 1, -1):
            elements.append(grid[i][cols - layer - 1])
        for i in range(cols - layer - 2, layer, -1):
            elements.append(grid[layer][i])

        n = len(elements)
        k %= n
        rotated_elements = elements[-k:] + elements[:-k]

        index = 0
        for i in range(layer, rows - layer):
            grid[i][layer] = rotated_elements[index]
            index += 1
        for i in range(layer + 1, cols - layer):
            grid[rows - layer - 1][i] = rotated_elements[index]
            index += 1
        for i in range(rows - layer - 2, layer - 1, -1):
            grid[i][cols - layer - 1] = rotated_elements[index]
            index += 1
        for i in range(cols - layer - 2, layer, -1):
            grid[layer][i] = rotated_elements[index]
            index += 1

    return grid