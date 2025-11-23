class Solution:
    def findWinningPlayer(self, x: int, y: int) -> bool:
        memo = {}

        def solve(current_x: int, current_y: int) -> bool:
            if (current_x, current_y) in memo:
                return memo[(current_x, current_y)]

            # Base case: A player loses if they cannot make any move.
            # A move requires at least 1 coin of type 1 (current_x >= 1).
            # Move 1 requires at least 1 coin of type 2 (current_y >= 1).
            # Move 2 requires at least 3 coins of type 2 (current_y >= 3).
            # Therefore, if current_x is 0, no move is possible.
            # If current_y is 0, no move is possible (as both moves require y >= 1).
            if current_x == 0 or current_y == 0:
                memo[(current_x, current_y)] = False
                return False

            # Try Move 1: spend 1 coin of type 1 and 1 coin of type 2.
            # This move is possible if current_x >= 1 and current_y >= 1.
            if current_x >= 1 and current_y >= 1:
                # If making this move leads to a state where the next player loses,
                # then the current player wins from the current state.
                if not solve(current_x - 1, current_y - 1):
                    memo[(current_x, current_y)] = True
                    return True

            # Try Move 2: spend 1 coin of type 1 and 3 coins of type 2.
            # This move is possible if current_x >= 1 and current_y >= 3.
            if current_x >= 1 and current_y >= 3:
                # If making this move leads to a state where the next player loses,
                # then the current player wins from the current state.
                if not solve(current_x - 1, current_y - 3):
                    memo[(current_x, current_y)] = True
                    return True

            # If neither available move leads to a losing state for the next player,
            # then the current player loses from this state.
            memo[(current_x, current_y)] = False
            return False

        # Alice goes first. Return true if Alice wins from the initial state (x, y).
        return solve(x, y)