class Solution:
    def solve(self, pieces: list[str], positions: list[str]) -> int:
        self.N = len(pieces)
        self.initial_positions = []
        for pos_str in positions:
            c = ord(pos_str[0]) - ord('a')
            r = int(pos_str[1]) - 1
            self.initial_positions.append((r, c))

        self.pieces = pieces
        self.ans = 0

        # Pre-calculate all possible raw moves for each piece from its initial position.
        # This includes staying put at initial_positions[k] and all moves on an empty board.
        self.all_possible_moves_for_piece = [[] for _ in range(self.N)]
        for k in range(self.N):
            start_r, start_c = self.initial_positions[k]
            piece_type = self.pieces[k]

            # Add option to stay put
            self.all_possible_moves_for_piece[k].append((start_r, start_c))

            # Add all other raw moves (on an otherwise empty board)
            moves = self._get_raw_moves(piece_type, start_r, start_c)
            self.all_possible_moves_for_piece[k].extend(moves)

        # Start DFS
        # k: index of the current piece being considered (from 0 to N-1).
        # current_piece_positions: list of (r, c) for each piece.
        #   For i < k, it's the chosen destination.
        #   For i >= k, it's the initial position.
        # captured_set: set of piece indices that have been captured.
        self._dfs(0, list(self.initial_positions), set())
        return self.ans

    def _dfs(self, k, current_piece_positions, captured_set):
        if k == self.N:
            self.ans += 1
            return

        start_r, start_c = self.initial_positions[k]
        piece_type = self.pieces[k]

        for end_r, end_c in self.all_possible_moves_for_piece[k]:
            is_valid_move = True
            new_captured_set = set(captured_set)

            # Case 1: Piece k stays put
            if (start_r, start_c) == (end_r, end_c):
                # Check if its initial square is occupied by any other active piece
                for p_idx in range(self.N):
                    if p_idx == k:
                        continue
                    if p_idx in captured_set:
                        continue
                    if current_piece_positions[p_idx] == (start_r, start_c):
                        is_valid_move = False
                        break

                if is_valid_move:
                    # Valid stay put. Recurse with piece k's position unchanged.
                    self._dfs(k + 1, current_piece_positions, captured_set)
                continue # Move to next possible move for piece k

            # Case 2: Piece k moves to a new square (end_r, end_c)

            # Path checking for sliding pieces (rook, bishop, queen)
            if piece_type in ["rook", "bishop", "queen"]:
                path_blocked = False
                dr = 0 if start_r == end_r else (1 if end_r > start_r else -1)
                dc = 0 if start_c == end_c else (1 if end_c > start_c else -1)

                curr_r, curr_c = start_r + dr, start_c + dc
                while (curr_r, curr_c) != (end_r, end_c): # Iterate through intermediate squares
                    for p_idx in range(self.N):
                        if p_idx == k or p_idx in captured_set:
                            continue
                        if current_piece_positions[p_idx] == (curr_r, curr_c):
                            path_blocked = True
                            break
                    if path_blocked:
                        break
                    curr_r += dr
                    curr_c += dc
                if path_blocked:
                    continue # This move is blocked by another piece, try next move

            # Check if destination square (end_r, end_c) is occupied by another piece
            target_piece_idx = -1
            for p_idx in range(self.N):
                if p_idx == k:
                    continue
                if p_idx in captured_set:
                    continue
                if current_piece_positions[p_idx] == (end_r, end_c):
                    target_piece_idx = p_idx
                    break

            if target_piece_idx != -1:
                # Destination square is occupied by piece target_piece_idx
                if target_piece_idx < k:
                    # Occupied by a piece that already moved (0 to k-1). Invalid move.
                    is_valid_move = False
                else: # target_piece_idx > k
                    # Occupied by a piece that has not yet moved (k+1 to N-1). This is a valid capture.
                    new_captured_set.add(target_piece_idx)

            if is_valid_move:
                # Make the move: update piece k's position
                next_piece_positions = list(current_piece_positions)
                next_piece_positions[k] = (end_r, end_c)

                self._dfs(k + 1, next_piece_positions, new_captured_set)

    def _is_valid(self, r, c):
        return 0 <= r < 8 and 0 <= c < 8

    # _get_raw_moves returns all squares a piece can reach on an empty board,
    # without considering intermediate pieces for sliding moves (path blocking is handled in DFS).
    def _get_raw_moves(self, piece_type, r, c):
        moves = []
        if piece_type == "rook":
            for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                for i in range(1, 8):
                    nr, nc = r + dr * i, c + dc * i
                    if self._is_valid(nr, nc):
                        moves.append((nr, nc))
                    else:
                        break # Hit board edge
        elif piece_type == "knight":
            for dr, dc in [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)]:
                nr, nc = r + dr, c + dc
                if self._is_valid(nr, nc):
                    moves.append((nr, nc))
        elif piece_type == "bishop":
            for dr, dc in [(-1, -1), (-1, 1), (1, -1), (1, 1)]:
                for i in range(1, 8):
                    nr, nc = r + dr * i, c + dc * i
                    if self._is_valid(nr, nc):
                        moves.append((nr, nc))
                    else:
                        break # Hit board edge
        elif piece_type == "queen":
            for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0), (-1, -1), (-1, 1), (1, -1), (1, 1)]:
                for i in range(1, 8):
                    nr, nc = r + dr * i, c + dc * i
                    if self._is_valid(nr, nc):
                        moves.append((nr, nc))
                    else:
                        break # Hit board edge
        elif piece_type == "pawn":
            # Assume white pawn, moving up (row increases)
            # Standard single forward move
            nr, nc = r + 1, c
            if self._is_valid(nr, nc):
                moves.append((nr, nc))
            # Diagonal moves (potential captures or moves to empty, handled by DFS logic)
            for dc in [-1, 1]:
                nr, nc = r + 1, c + dc
                if self._is_valid(nr, nc):
                    moves.append((nr, nc))

        return moves