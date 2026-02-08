import collections
import functools

class Solution:
    def findMinStep(self, board: str, hand: str) -> int:

        # Map colors to indices for tuple representation of hand counts
        color_map = {'R': 0, 'Y': 1, 'B': 2, 'G': 3, 'W': 4}
        idx_to_color = ['R', 'Y', 'B', 'G', 'W']

        # Initial hand counts
        initial_hand_counts = [0] * 5
        for char in hand:
            initial_hand_counts[color_map[char]] += 1

        # Convert to tuple for memoization (tuple is hashable)
        initial_hand_tuple = tuple(initial_hand_counts)

        # Helper function to clean the board by removing consecutive balls >= 3
        def clean(s: str) -> str:
            while True:
                n = len(s)
                if n == 0:
                    return ""

                i = 0
                res_parts = []
                found_removal = False
                while i < n:
                    j = i
                    while j < n and s[j] == s[i]:
                        j += 1
                    count = j - i

                    if count < 3:
                        res_parts.append(s[i:j])
                    else:
                        found_removal = True # Indicate that a removal happened
                    i = j

                new_s = "".join(res_parts)

                if not found_removal: # If no removals happened in this pass, we are done
                    break
                s = new_s # Continue cleaning with the new string
            return s

        # Memoization cache for the recursive function
        @functools.lru_cache(None)
        def solve(current_board: str, current_hand_tuple: tuple) -> int:
            # Base case: if the board is empty, 0 balls are needed
            if not current_board:
                return 0

            # Convert hand tuple back to a mutable list for easier manipulation
            current_hand_list = list(current_hand_tuple)

            min_balls = float('inf')

            # Iterate through all possible balls in hand
            for color_idx in range(5):
                if current_hand_list[color_idx] > 0:
                    ball_to_insert = idx_to_color[color_idx]

                    # Iterate through all possible insertion points
                    # This includes inserting at the beginning (idx 0) and end (len(board))
                    for i in range(len(current_board) + 1):
                        # Construct new board after insertion
                        temp_board = current_board[:i] + ball_to_insert + current_board[i:]

                        # Clean the board after insertion
                        cleaned_board = clean(temp_board)

                        # Use one ball from hand
                        current_hand_list[color_idx] -= 1
                        new_hand_tuple = tuple(current_hand_list)

                        # Recurse to find the minimum steps for the new state
                        res = solve(cleaned_board, new_hand_tuple)

                        # If a path was found (not infinity), update min_balls
                        if res != float('inf'):
                            min_balls = min(min_balls, 1 + res)

                        # Backtrack: restore hand count for the next iteration
                        current_hand_list[color_idx] += 1

            return min_balls

        # Start the DFS from the initial board and hand
        result = solve(board, initial_hand_tuple)

        # If the result is still infinity, it means no solution was found
        return result if result != float('inf') else -1