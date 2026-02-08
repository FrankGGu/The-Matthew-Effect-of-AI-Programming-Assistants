class Solution:
    def transform(self, n, mismatches_to_0101):
        if n % 2 == 0:
            # For even n, both 0,1,0,1... and 1,0,1,0... patterns have n/2 zeros and n/2 ones.
            # If mismatches_to_0101 is odd, it means the current line does not have n/2 zeros and n/2 ones.
            # Thus, it cannot be transformed into either target pattern.
            if mismatches_to_0101 % 2 != 0:
                return float('inf') # Impossible

            swaps_to_0101 = mismatches_to_0101 // 2
            swaps_to_1010 = (n - mismatches_to_0101) // 2
            return min(swaps_to_0101, swaps_to_1010)
        else:
            # For odd n, 0,1,0,1... pattern has (n+1)/2 of the starting bit and (n-1)/2 of the other.
            # 1,0,1,0... pattern has (n-1)/2 of the starting bit and (n+1)/2 of the other.
            # If mismatches_to_0101 is even, it means the current line has the same counts of 0s/1s as 0,1,0,1...
            # If mismatches_to_0101 is odd, it means the current line has the same counts of 0s/1s as 1,0,1,0...
            if mismatches_to_0101 % 2 == 0:
                return mismatches_to_0101 // 2
            else:
                return (n - mismatches_to_0101) // 2

    def movesToChessboard(self, board: list[list[int]]) -> int:
        n = len(board)

        # 1. Validity Check: All rows must be either board[0] or ~board[0],
        # and all columns must be either col[0] or ~col[0].
        # This is equivalent to board[i][j] ^ board[i][0] ^ board[0][j] ^ board[0][0] == 0 for all i,j.
        for i in range(1, n):
            for j in range(1, n):
                if (board[i][j] ^ board[i][0] ^ board[0][j] ^ board[0][0]) != 0:
                    return -1

        # 2. Extract first row and first column for analysis
        first_row = board[0]
        first_col = [board[i][0] for i in range(n)]

        # 3. Calculate mismatches for first row to match 0,1,0,1... pattern
        row_mismatches_to_0101 = 0
        for j in range(n):
            if first_row[j] != j % 2:
                row_mismatches_to_0101 += 1

        # 4. Calculate mismatches for first column to match 0,1,0,1... pattern
        col_mismatches_to_0101 = 0
        for i in range(n):
            if first_col[i] != i % 2:
                col_mismatches_to_0101 += 1

        # 5. Calculate minimum swaps for rows and columns
        # There are two potential target chessboards: one starting with 0 at (0,0) and one with 1 at (0,0).
        # We calculate moves for both and take the minimum.

        ans = float('inf')

        # Option A: Target chessboard starts with 0 at (0,0)
        # This means the first row should be 0,1,0,1... and the first column should be 0,1,0,1...

        # Calculate row swaps needed to make first column 0,1,0,1...
        # The `transform` function handles the parity and count checks for n even/odd.
        row_swaps_target0 = self.transform(n, col_mismatches_to_0101) # Use col_mismatches for row swaps (first col elements)

        # Calculate column swaps needed to make first row 0,1,0,1...
        col_swaps_target0 = self.transform(n, row_mismatches_to_0101) # Use row_mismatches for col swaps (first row elements)

        if row_swaps_target0 != float('inf') and col_swaps_target0 != float('inf'):
            ans = min(ans, row_swaps_target0 + col_swaps_target0)

        # Option B: Target chessboard starts with 1 at (0,0)
        # This means the first row should be 1,0,1,0... and the first column should be 1,0,1,0...
        # The mismatches for 1,0,1,0... pattern are (n - mismatches_to_0101).

        # Calculate row swaps needed to make first column 1,0,1,0...
        row_swaps_target1 = self.transform(n, n - col_mismatches_to_0101)

        # Calculate column swaps needed to make first row 1,0,1,0...
        col_swaps_target1 = self.transform(n, n - row_mismatches_to_0101)

        if row_swaps_target1 != float('inf') and col_swaps_target1 != float('inf'):
            ans = min(ans, row_swaps_target1 + col_swaps_target1)

        if ans == float('inf'):
            return -1
        return ans