class Solution:
    def catAndMouse(self, graph: list[list[int]]) -> int:
        N = len(graph)
        # dp[mouse_pos][cat_pos][turn] stores the outcome for a given state.
        # turn: 0 for mouse, 1 for cat
        # Outcome: 0 for draw, 1 for mouse win, 2 for cat win
        # Initialize with -1 (uncomputed)
        dp = [[[-1] * 2 for _ in range(N)] for _ in range(N)]

        def dfs(m_pos, c_pos, turn):
            # Base cases
            # Mouse wins if it reaches hole 0
            if m_pos == 0:
                return 1
            # Cat wins if it catches the mouse
            if m_pos == c_pos:
                return 2

            # Memoization: if this state has already been computed, return its result
            if dp[m_pos][c_pos][turn] != -1:
                return dp[m_pos][c_pos][turn]

            # Mark the current state as a draw (0) temporarily to detect cycles.
            # If a cycle is detected, this temporary value will be returned,
            # correctly propagating a draw. If a win/loss is determined, it will be updated.
            dp[m_pos][c_pos][turn] = 0

            if turn == 0:  # Mouse's turn
                mouse_can_win = False
                mouse_can_draw = False

                for next_m_pos in graph[m_pos]:
                    result = dfs(next_m_pos, c_pos, 1)
                    if result == 1:  # Mouse found a winning move
                        mouse_can_win = True
                        break
                    if result == 0:  # Mouse found a drawing move
                        mouse_can_draw = True

                if mouse_can_win:
                    dp[m_pos][c_pos][turn] = 1
                elif mouse_can_draw:
                    dp[m_pos][c_pos][turn] = 0
                else:  # Mouse can only lose
                    dp[m_pos][c_pos][turn] = 2
            else:  # Cat's turn
                cat_can_win = False
                cat_can_draw = False

                for next_c_pos in graph[c_pos]:
                    if next_c_pos == 0:  # Cat cannot move to hole 0
                        continue

                    result = dfs(m_pos, next_c_pos, 0)
                    if result == 2:  # Cat found a winning move
                        cat_can_win = True
                        break
                    if result == 0:  # Cat found a drawing move
                        cat_can_draw = True

                if cat_can_win:
                    dp[m_pos][c_pos][turn] = 2
                elif cat_can_draw:
                    dp[m_pos][c_pos][turn] = 0
                else:  # Cat can only lose
                    dp[m_pos][c_pos][turn] = 1

            return dp[m_pos][c_pos][turn]

        # Initial state: Mouse at 1, Cat at 2, Mouse's turn (0)
        return dfs(1, 2, 0)