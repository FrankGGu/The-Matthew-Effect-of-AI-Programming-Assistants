from collections import deque

class Solution:
    def containVirus(self, grid: list[list[int]]) -> int:
        R, C = len(grid), len(grid[0])
        total_walls = 0

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        def find_components():
            components = [] # List of (potential_infections_count, walls_needed, component_cells, potential_infections_set)
            visited = [[False] * C for _ in range(R)]

            for r in range(R):
                for c in range(C):
                    if grid[r][c] == 1 and not visited[r][c]:
                        q = deque([(r, c)])
                        visited[r][c] = True

                        current_component_cells = set([(r,c)])
                        potential_infections_set = set()
                        walls_needed_for_component = 0

                        while q:
                            curr_r, curr_c = q.popleft()

                            for i in range(4):
                                nr, nc = curr_r + dr[i], curr_c + dc[i]

                                if 0 <= nr < R and 0 <= nc < C:
                                    if grid[nr][nc] == 1 and not visited[nr][nc]:
                                        visited[nr][nc] = True
                                        current_component_cells.add((nr, nc))
                                        q.append((nr, nc))
                                    elif grid[nr][nc] == 0: # Healthy cell
                                        potential_infections_set.add((nr, nc))
                                        walls_needed_for_component += 1

                        if potential_infections_set:
                            components.append((len(potential_infections_set), walls_needed_for_component, current_component_cells, potential_infections_set))

            return components

        while True:
            components = find_components()

            if not components:
                break

            best_component_idx = -1
            max_infections = -1

            for i, (infections_count, _, _, _) in enumerate(components):
                if infections_count > max_infections:
                    max_infections = infections_count
                    best_component_idx = i

            # This check is technically redundant because find_components only returns
            # components with potential_infections_set not empty, so max_infections will be > 0.
            # However, it doesn't hurt.
            if max_infections == 0:
                break

            chosen_component_infections_count, chosen_walls, chosen_cells, chosen_infections_set = components[best_component_idx]

            total_walls += chosen_walls

            for r, c in chosen_cells:
                grid[r][c] = -1 # Wall off the infected cells of the chosen component

            for i, (infections_count, _, other_cells, other_infections_set) in enumerate(components):
                if i == best_component_idx:
                    continue # Skip the walled-off component

                for r_inf, c_inf in other_infections_set:
                    if grid[r_inf][c_inf] == 0: # Only infect if it's still healthy
                        grid[r_inf][c_inf] = 1 # Spread

        return total_walls