class Solution:
    def orchestraLayout(self, num: int, xPos: int, yPos: int) -> int:
        n = num
        x = xPos
        y = yPos

        # Determine the layer k for the cell (x, y)
        # k is the minimum distance from any border (top, bottom, left, right)
        k = min(x, y, n - 1 - x, n - 1 - y)

        # Calculate the total number of cells in all outer layers (layers 0 to k-1).
        # This is equivalent to the total cells in the n x n grid minus the cells
        # in the inner (n-2k) x (n-2k) square.
        # The number of cells in the outer k layers is n^2 - (n-2k)^2.
        # This simplifies to 4 * k * (n - k).
        base_count = 4 * k * (n - k)

        # Calculate the side length of the current layer k square.
        s = n - 2 * k

        # If the current layer is a 1x1 square (this happens when n is odd and (x,y) is the center cell).
        if s == 1:
            # The center cell is the next number after all outer layers.
            # Apply the 1-9 cycling rule.
            return ((base_count) % 9) + 1

        # Otherwise, calculate the position within the current layer k.
        # Numbering starts from the top-left corner of the current layer (k, k) and proceeds clockwise.

        current_layer_offset = 0

        # Case 1: Cell is on the top side of the current layer.
        # Coordinates: (k, y) where k <= y <= n - 1 - k.
        if x == k:
            current_layer_offset = y - k + 1
        # Case 2: Cell is on the right side of the current layer.
        # Coordinates: (x, n - 1 - k) where k < x <= n - 1 - k.
        elif y == n - 1 - k:
            current_layer_offset = s  # All 's' cells on the top side
            current_layer_offset += (x - k) # Cells on the right side, starting from (k+1, n-1-k)
        # Case 3: Cell is on the bottom side of the current layer.
        # Coordinates: (n - 1 - k, y) where k <= y < n - 1 - k.
        elif x == n - 1 - k:
            current_layer_offset = s  # All 's' cells on the top side
            current_layer_offset += (s - 1) # All 's-1' cells on the right side (excluding top-right corner)
            current_layer_offset += ((n - 1 - k) - y) # Cells on the bottom side, moving left from (n-1-k, n-1-k-1)
        # Case 4: Cell is on the left side of the current layer.
        # Coordinates: (x, k) where k < x < n - 1 - k.
        else: # y == k
            current_layer_offset = s  # All 's' cells on the top side
            current_layer_offset += (s - 1) # All 's-1' cells on the right side
            current_layer_offset += (s - 1) # All 's-1' cells on the bottom side (excluding bottom-left corner)
            current_layer_offset += ((n - 1 - k) - x) # Cells on the left side, moving up from (n-1-k-1, k)

        # The final result is the total count (base_count + current_layer_offset)
        # adjusted for the 1-9 cycling rule.
        # (value - 1) % 9 + 1 ensures that 1 maps to 1, 9 maps to 9, 10 maps to 1, etc.
        return ((base_count + current_layer_offset - 1) % 9) + 1