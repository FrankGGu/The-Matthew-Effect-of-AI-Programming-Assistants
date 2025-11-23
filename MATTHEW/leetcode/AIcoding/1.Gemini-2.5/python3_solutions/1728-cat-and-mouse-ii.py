from typing import List

class Solution:
    def canMouseWin(self, grid: List[str], mouse_jump: int, cat_jump: int) -> bool:
        rows, cols = len(grid), len(grid[0])

        mouse_start = (-1, -1)
        cat_start = (-1, -1)
        food_pos = (-1, -1)

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 'M':
                    mouse_start = (r, c)
                elif grid[r][c] == 'C':
                    cat_start = (r, c)
                elif grid[r][c] == 'F':
                    food_pos = (r, c)

        DRAW = 0
        MOUSE_WIN = 1
        CAT_WIN = 2

        memo = {} # Stores (mouse_r, mouse_c, cat_r, cat_c, turn) -> outcome

        # Cardinal directions for movement (excluding (0,0) for jumping)
        cardinal_dirs = [(0,1), (0,-1), (1,0), (-1,0)]

        def is_valid(r, c):
            return 0 <= r < rows and 0 <= c < cols and grid[r][c] != '#'

        def dp(mouse_r, mouse_c, cat_r, cat_c, turn_idx):
            state = (mouse_r, mouse_c, cat_r, cat_c, turn_idx)

            if state in memo:
                return memo[state]

            # Base cases (immediate outcomes) - order matters based on problem rules
            # 1. Cat catches mouse
            if (mouse_r, mouse_c) == (cat_r, cat_c):
                memo[state] = CAT_WIN
                return CAT_WIN
            # 2. Cat reaches food
            if (cat_r, cat_c) == food_pos:
                memo[state] = CAT_WIN
                return CAT_WIN
            # 3. Mouse reaches food (and cat is not there, and cat is not on food)
            if (mouse_r, mouse_c) == food_pos:
                memo[state] = MOUSE_WIN
                return MOUSE_WIN

            # Mark the current state as DRAW temporarily to detect cycles.
            # If we encounter this state again during the current recursion path,
            # it means a cycle is detected, implying a DRAW.
            memo[state] = DRAW 

            can_current_player_win = False
            can_current_player_draw = False

            if turn_idx == 0:  # Mouse's turn
                current_player_win = MOUSE_WIN
                opponent_win = CAT_WIN

                # Mouse can stay put
                res = dp(mouse_r, mouse_c, cat_r, cat_c, 1)
                if res == current_player_win:
                    can_current_player_win = True
                elif res == DRAW:
                    can_current_player_draw = True

                # If mouse can win by staying, no need to explore jumps
                if can_current_player_win:
                    memo[state] = current_player_win
                    return current_player_win

                # Mouse can jump in cardinal directions
                for dr, dc in cardinal_dirs:
                    for s in range(1, mouse_jump + 1): # s from 1 to mouse_jump
                        next_mouse_r = mouse_r + dr * s
                        next_mouse_c = mouse_c + dc * s

                        if not is_valid(next_mouse_r, next_mouse_c):
                            break # Hit an obstacle or out of bounds, stop jumping further in this direction

                        res = dp(next_mouse_r, next_mouse_c, cat_r, cat_c, 1)
                        if res == current_player_win:
                            can_current_player_win = True
                            break # Found a winning move for mouse, no need to check further
                        elif res == DRAW:
                            can_current_player_draw = True

                    if can_current_player_win:
                        break # Break from outer (dr, dc) loop if a winning move was found

            else:  # Cat's turn
                current_player_win = CAT_WIN
                opponent_win = MOUSE_WIN

                # Cat must move/jump in cardinal directions
                for dr, dc in cardinal_dirs:
                    for s in range(1, cat_jump + 1): # s from 1 to cat_jump
                        next_cat_r = cat_r + dr * s
                        next_cat_c = cat_c + dc * s

                        if not is_valid(next_cat_r, next_cat_c):
                            break # Hit an obstacle or out of bounds, stop jumping further in this direction

                        res = dp(mouse_r, mouse_c, next_cat_r, next_cat_c, 0)
                        if res == current_player_win:
                            can_current_player_win = True
                            break # Found a winning move for cat, no need to check further
                        elif res == DRAW:
                            can_current_player_draw = True

                    if can_current_player_win:
                        break # Break from outer (dr, dc) loop if a winning move was found

            # After checking all possible moves for the current player
            if can_current_player_win:
                memo[state] = current_player_win
                return current_player_win
            elif can_current_player_draw:
                memo[state] = DRAW
                return DRAW
            else: # All moves lead to opponent winning
                memo[state] = opponent_win
                return opponent_win

        # The game starts with the mouse's turn (turn_idx = 0)
        result = dp(mouse_start[0], mouse_start[1], cat_start[0], cat_start[1], 0)
        return result == MOUSE_WIN