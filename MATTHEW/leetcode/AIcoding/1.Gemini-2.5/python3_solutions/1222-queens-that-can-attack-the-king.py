class Solution:
    def queensAttacktheKing(self, queens: list[list[int]], king: list[int]) -> list[list[int]]:
        king_row, king_col = king[0], king[1]

        queen_set = set()
        for r, c in queens:
            queen_set.add((r, c))

        attacking_queens = []

        # Directions: Up, Down, Left, Right, Diagonals
        # dr = [-1, 1, 0, 0, -1, -1, 1, 1]
        # dc = [0, 0, -1, 1, -1, 1, -1, 1]

        # Combined directions: (dr, dc)
        directions = [
            (-1, 0),  # Up
            (1, 0),   # Down
            (0, -1),  # Left
            (0, 1),   # Right
            (-1, -1), # Up-Left
            (-1, 1),  # Up-Right
            (1, -1),  # Down-Left
            (1, 1)    # Down-Right
        ]

        for dr, dc in directions:
            r, c = king_row, king_col
            while True:
                r += dr
                c += dc

                if not (0 <= r < 8 and 0 <= c < 8):
                    break

                if (r, c) in queen_set:
                    attacking_queens.append([r, c])
                    break

        return attacking_queens