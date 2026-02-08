class Solution:
    def get_initial_ray_state(self, n: int, ray_idx: int) -> tuple:
        """
        Determines the initial position (r, c) and direction (dr, dc)
        for a ray given its entry index.
        """
        if 0 <= ray_idx < n:  # Top edge, moving down
            r, c, dr, dc = 0, ray_idx, 1, 0
        elif n <= ray_idx < 2 * n:  # Right edge, moving left
            r, c, dr, dc = ray_idx - n, n - 1, 0, -1
        elif 2 * n <= ray_idx < 3 * n:  # Bottom edge, moving up
            # c goes from n-1 down to 0 for indices 2*n to 3*n-1
            r, c, dr, dc = n - 1, n - 1 - (ray_idx - 2 * n), -1, 0
        else:  # 3 * n <= ray_idx < 4 * n  # Left edge, moving right
            # r goes from n-1 down to 0 for indices 3*n to 4*n-1
            r, c, dr, dc = n - 1 - (ray_idx - 3 * n), 0, 0, 1
        return r, c, dr, dc

    def simulate_ray(self, n: int, mirror_grid: list[list[int]], curr_r: int, curr_c: int, curr_dr: int, curr_dc: int) -> int:
        """
        Simulates the path of a single light ray and returns its exit index.
        curr_r, curr_c: current position of the ray.
        curr_dr, curr_dc: current direction of the ray.
        mirror_grid: 0 for empty, 1 for '\', 2 for '/'.
        """
        while True:
            # Check if the *next* cell (curr_r + curr_dr, curr_c + curr_dc) is out of bounds.
            # If it is, then (curr_r, curr_c) is the exit point.
            # The direction (curr_dr, curr_dc) indicates from which side it is exiting.
            if not (0 <= curr_r + curr_dr < n and 0 <= curr_c + curr_dc < n):
                # Exited the box. (curr_r, curr_c) is the boundary point.
                # Determine which side it exited from based on the direction of exit.
                if curr_dr == 1:  # Moving down, exited from bottom edge
                    return 2 * n + (n - 1 - curr_c)
                elif curr_dr == -1:  # Moving up, exited from top edge
                    return curr_c
                elif curr_dc == 1:  # Moving right, exited from right edge
                    return n + curr_r
                else:  # curr_dc == -1, Moving left, exited from left edge
                    return 3 * n + (n - 1 - curr_r)

            # Move to the next cell
            curr_r += curr_dr
            curr_c += curr_dc

            mirror_type = mirror_grid[curr_r][curr_c]
            if mirror_type == 1:  # Mirror '\'
                # (dr, dc) -> (-dc, -dr)
                curr_dr, curr_dc = -curr_dc, -curr_dr
            elif mirror_type == 2:  # Mirror '/'
                # (dr, dc) -> (dc, dr)
                curr_dr, curr_dc = curr_dc, curr_dr
            # If mirror_type == 0 (empty), direction remains unchanged.

    def blackBox(self, n: int, mirrors: list[list[int]], rays: list[int]) -> list[int]:
        """
        Main function to solve the Black Box Light Reflection problem.
        """
        # Initialize the grid to store mirror types
        # 0: empty, 1: '\', 2: '/'
        mirror_grid = [[0] * n for _ in range(n)]
        for m_r, m_c, m_type in mirrors:
            mirror_grid[m_r][m_c] = 1 if m_type == '\\' else 2

        results = []
        for ray_idx in rays:
            start_r, start_c, start_dr, start_dc = self.get_initial_ray_state(n, ray_idx)
            exit_idx = self.simulate_ray(n, mirror_grid, start_r, start_c, start_dr, start_dc)
            results.append(exit_idx)

        return results