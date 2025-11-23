import collections

class Solution:
    def hasValidPath(self, grid: list[list[int]]) -> bool:
        m, n = len(grid), len(grid[0])

        # Define connections for each street type
        # Each street type maps to a list of (dr, dc) tuples representing directions it connects to.
        # (dr, dc): (-1, 0) Up, (1, 0) Down, (0, -1) Left, (0, 1) Right
        street_connections = {
            1: [(0, -1), (0, 1)],  # Left, Right
            2: [(-1, 0), (1, 0)],  # Up, Down
            3: [(0, -1), (1, 0)],  # Left, Down
            4: [(0, 1), (1, 0)],   # Right, Down
            5: [(0, -1), (-1, 0)], # Left, Up
            6: [(0, 1), (-1, 0)]   # Right, Up
        }

        # Define opposite directions for checking valid connections between streets
        opposite_dir = {
            (-1, 0): (1, 0),   # Up -> Down
            (1, 0): (-1, 0),   # Down -> Up
            (0, -1): (0, 1),   # Left -> Right
            (0, 1): (0, -1)    # Right -> Left
        }

        queue = collections.deque([(0, 0)])
        visited = set([(0, 0)])

        while queue:
            r, c = queue.popleft()

            if r == m - 1 and c == n - 1:
                return True

            current_street_type = grid[r][c]

            for dr, dc in street_connections[current_street_type]:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n and (nr, nc) not in visited:
                    next_street_type = grid[nr][nc]

                    # Check if the next street has an opening that connects back to the current street.
                    # This means the opposite direction of the current move (dr, dc) must be
                    # one of the valid connections for the next street type.
                    if opposite_dir[(dr, dc)] in street_connections[next_street_type]:
                        visited.add((nr, nc))
                        queue.append((nr, nc))

        return False