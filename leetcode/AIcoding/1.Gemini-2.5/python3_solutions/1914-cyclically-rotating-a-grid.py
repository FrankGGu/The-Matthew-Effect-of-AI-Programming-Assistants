class Solution:
    def rotateGrid(self, grid: list[list[int]], k: int) -> list[list[int]]:
        m, n = len(grid), len(grid[0])

        r1, c1 = 0, 0
        r2, c2 = m - 1, n - 1

        while r1 <= r2 and c1 <= c2:
            layer_elements = []

            # Extract elements of the current layer
            # Top side: from (r1, c1) to (r1, c2)
            for j in range(c1, c2 + 1):
                layer_elements.append(grid[r1][j])

            # Right side: from (r1 + 1, c2) to (r2, c2)
            for i in range(r1 + 1, r2 + 1):
                layer_elements.append(grid[i][c2])

            # Bottom side: from (r2, c2 - 1) to (r2, c1)
            # Only if it's not a single row (i.e., r1 != r2)
            if r1 != r2:
                for j in range(c2 - 1, c1 - 1, -1):
                    layer_elements.append(grid[r2][j])

            # Left side: from (r2 - 1, c1) to (r1 + 1, c1)
            # Only if it's not a single column (i.e., c1 != c2)
            if c1 != c2:
                for i in range(r2 - 1, r1, -1):
                    layer_elements.append(grid[i][c1])

            # Rotate the extracted elements
            num_elements = len(layer_elements)
            if num_elements == 0:
                break # Should not happen if r1 <= r2 and c1 <= c2

            k_eff = k % num_elements
            rotated_elements = layer_elements[k_eff:] + layer_elements[:k_eff]

            # Place the rotated elements back into the grid
            current_idx = 0

            # Top side
            for j in range(c1, c2 + 1):
                grid[r1][j] = rotated_elements[current_idx]
                current_idx += 1

            # Right side
            for i in range(r1 + 1, r2 + 1):
                grid[i][c2] = rotated_elements[current_idx]
                current_idx += 1

            # Bottom side
            if r1 != r2:
                for j in range(c2 - 1, c1 - 1, -1):
                    grid[r2][j] = rotated_elements[current_idx]
                    current_idx += 1

            # Left side
            if c1 != c2:
                for i in range(r2 - 1, r1, -1):
                    grid[i][c1] = rotated_elements[current_idx]
                    current_idx += 1

            # Move to the next inner layer
            r1 += 1
            c1 += 1
            r2 -= 1
            c2 -= 1

        return grid