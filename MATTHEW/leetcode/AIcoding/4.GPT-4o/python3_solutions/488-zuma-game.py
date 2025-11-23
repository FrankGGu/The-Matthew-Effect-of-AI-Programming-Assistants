class Solution:
    def findMinStep(self, board: str, hand: str) -> int:
        from collections import Counter

        def dfs(board, hand_count):
            if not board:
                return 0
            if not any(hand_count):
                return float('inf')

            min_steps = float('inf')
            i = 0
            while i < len(board):
                j = i
                while j < len(board) and board[j] == board[i]:
                    j += 1
                needed_balls = max(0, 3 - (j - i))
                if hand_count[board[i]] >= needed_balls:
                    hand_count[board[i]] -= needed_balls
                    new_board = board[:i] + board[j:]
                    next_steps = dfs(new_board, hand_count)
                    if next_steps != float('inf'):
                        min_steps = min(min_steps, next_steps + needed_balls)
                    hand_count[board[i]] += needed_balls
                i = j

            return min_steps

        hand_count = Counter(hand)
        result = dfs(board, hand_count)
        return result if result != float('inf') else -1