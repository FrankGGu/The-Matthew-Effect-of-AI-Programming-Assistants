import collections

class Solution:
    def minPushBox(self, grid: list[list[str]]) -> int:
        R, C = len(grid), len(grid[0])

        start_bx, start_by = -1, -1
        start_px, start_py = -1, -1
        target_x, target_y = -1, -1

        for r in range(R):
            for c in range(C):
                if grid[r][c] == 'B':
                    start_bx, start_by = r, c
                elif grid[r][c] == 'S':
                    start_px, start_py = r, c
                elif grid[r][c] == 'T':
                    target_x, target_y = r, c

        # State: (box_row, box_col, player_row, player_col)
        # Value in queue: (pushes, bx, by, px, py)
        q = collections.deque([(0, start_bx, start_by, start_px, start_py)])

        # Visited set stores (bx, by, px, py)
        visited = set([(start_bx, start_by, start_px, start_py)])

        # Directions for player movement and box push
        # (dr, dc)
        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)] # right, left, down, up

        while q:
            pushes, bx, by, px, py = q.popleft()

            if bx == target_x and by == target_y:
                return pushes

            # Player's free movement (cost 0)
            for dr, dc in dirs:
                npx, npy = px + dr, py + dc

                # Check bounds for new player position
                if not (0 <= npx < R and 0 <= npy < C):
                    continue

                # Check if new player position is a wall
                if grid[npx][npy] == '#':
                    continue

                # Check if new player position is occupied by the box
                if npx == bx and npy == by:
                    continue

                # If valid and not visited, add to queue with cost 0
                if (bx, by, npx, npy) not in visited:
                    visited.add((bx, by, npx, npy))
                    q.appendleft((pushes, bx, by, npx, npy))

            # Box push (cost 1)
            for dr, dc in dirs:
                # new box position
                next_bx, next_by = bx + dr, by + dc

                # player's required position to push the box in (dr, dc) direction
                # Player must be on the opposite side of the box
                player_required_x, player_required_y = bx - dr, by - dc

                # Check bounds for new box position
                if not (0 <= next_bx < R and 0 <= next_by < C):
                    continue

                # Check if new box position is a wall
                if grid[next_bx][next_by] == '#':
                    continue

                # Check bounds for player's required position
                if not (0 <= player_required_x < R and 0 <= player_required_y < C):
                    continue

                # Check if player's required position is a wall
                if grid[player_required_x][player_required_y] == '#':
                    continue

                # If current player position is the required position to push
                if px == player_required_x and py == player_required_y:
                    # Player moves to the box's old position
                    new_player_pos_x, new_player_pos_y = bx, by

                    if (next_bx, next_by, new_player_pos_x, new_player_pos_y) not in visited:
                        visited.add((next_bx, next_by, new_player_pos_x, new_player_pos_y))
                        q.append((pushes + 1, next_bx, next_by, new_player_pos_x, new_player_pos_y))

        return -1