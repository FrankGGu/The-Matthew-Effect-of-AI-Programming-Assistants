#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_PIECES 4
#define MAX_MOVES_PER_PIECE 64 // Upper bound for 8x8 board

enum PieceType {
    ROOK,
    QUEEN,
    BISHOP
};

typedef struct {
    int r, c;
} Pos;

typedef struct {
    enum PieceType type;
    Pos start_pos;
} Piece;

Piece g_pieces[MAX_PIECES];
int g_numPieces;
Pos g_allPossibleMoves[MAX_PIECES][MAX_MOVES_PER_PIECE];
int g_numPossibleMoves[MAX_PIECES];
int g_initialBoard[8][8]; // Stores piece index or -1 if empty
int g_totalValidCombinations;

const int DR[] = {0, 0, 1, -1, 1, 1, -1, -1};
const int DC[] = {1, -1, 0, 0, 1, -1, 1, -1};
const int ROOK_DIR_COUNT = 4;
const int BISHOP_DIR_COUNT = 4;
const int QUEEN_DIR_COUNT = 8;

static bool isValid(int r, int c) {
    return r >= 0 && r < 8 && c >= 0 && c < 8;
}

static Pos parsePosition(const char* s) {
    Pos p;
    p.c = s[0] - 'a';
    p.r = s[1] - '1';
    return p;
}

static void generateMovesForPiece(int pieceIdx) {
    Piece currentPiece = g_pieces[pieceIdx];
    Pos start_pos = currentPiece.start_pos;
    g_numPossibleMoves[pieceIdx] = 0;

    int dir_start, dir_end;
    if (currentPiece.type == ROOK) {
        dir_start = 0; dir_end = ROOK_DIR_COUNT;
    } else if (currentPiece.type == BISHOP) {
        dir_start = ROOK_DIR_COUNT; dir_end = ROOK_DIR_COUNT + BISHOP_DIR_COUNT;
    } else { // QUEEN
        dir_start = 0; dir_end = QUEEN_DIR_COUNT;
    }

    for (int i = dir_start; i < dir_end; ++i) {
        int dr = DR[i];
        int dc = DC[i];
        int r = start_pos.r + dr;
        int c = start_pos.c + dc;

        while (isValid(r, c)) {
            // Check if this square is occupied by another piece's initial position
            if (g_initialBoard[r][c] != -1) {
                break; // Obstacle, stop in this direction
            }
            // Add this square as a possible destination
            g_allPossibleMoves[pieceIdx][g_numPossibleMoves[pieceIdx]++] = (Pos){r, c};
            r += dr;
            c += dc;
        }
    }
}

static bool checkCombinationValidity(Pos currentCombination[MAX_PIECES]) {
    // 1. Check for unique destinations and that each piece moves to a new square
    int finalBoard[8][8];
    for (int i = 0; i < 8; ++i) {
        for (int j = 0; j < 8; ++j) {
            finalBoard[i][j] = -1; // -1 means empty, piece index if occupied
        }
    }

    for (int i = 0; i < g_numPieces; ++i) {
        Pos start = g_pieces[i].start_pos;
        Pos dest = currentCombination[i];

        // Each piece must move to a new square
        if (start.r == dest.r && start.c == dest.c) {
            return false;
        }

        // Check for duplicate destination
        if (finalBoard[dest.r][dest.c] != -1) {
            return false; // Duplicate destination
        }
        finalBoard[dest.r][dest.c] = i; // Mark destination with piece index
    }

    // 2. Check for path collisions (initial positions and final positions)
    for (int i = 0; i < g_numPieces; ++i) {
        Pos start = g_pieces[i].start_pos;
        Pos dest = currentCombination[i];

        // Determine direction vector (dr, dc)
        int dr = 0, dc = 0;
        if (start.r == dest.r) { // Horizontal move
            dr = 0;
            dc = (dest.c > start.c) ? 1 : -1;
        } else if (start.c == dest.c) { // Vertical move
            dc = 0;
            dr = (dest.r > start.r) ? 1 : -1;
        } else if (abs(start.r - dest.r) == abs(start.c - dest.c)) { // Diagonal move
            dr = (dest.r > start.r) ? 1 : -1;
            dc = (dest.c > start.c) ? 1 : -1;
        } else {
            // This case implies an invalid move type, which should be filtered by generateMovesForPiece.
            // However, it's a safeguard.
            return false;
        }

        // Iterate along the path (excluding start and end points)
        int r = start.r + dr;
        int c = start.c + dc;
        while (r != dest.r || c != dest.c) {
            // Check for collision with another piece's initial position
            // (g_initialBoard[r][c] != i) ensures it's not the current piece's own starting square,
            // which is not possible for intermediate squares anyway.
            if (g_initialBoard[r][c] != -1 && g_initialBoard[r][c] != i) {
                return false; // Collision with another piece's initial position
            }

            // Check for collision with another piece's final position
            // (finalBoard[r][c] != i) ensures it's not the current piece's own destination square,
            // which is not possible for intermediate squares anyway.
            if (finalBoard[r][c] != -1 && finalBoard[r][c] != i) {
                return false; // Collision with another piece's final position
            }

            r += dr;
            c += dc;
        }
    }

    return true;
}

static void backtrack(int pieceIdx, Pos currentCombination[MAX_PIECES]) {
    if (pieceIdx == g_numPieces) {
        // All pieces have chosen a move, now check if this combination is valid
        if (checkCombinationValidity(currentCombination)) {
            g_totalValidCombinations++;
        }
        return;
    }

    // Try all possible moves for the current piece
    for (int i = 0; i < g_numPossibleMoves[pieceIdx]; ++i) {
        currentCombination[pieceIdx] = g_allPossibleMoves[pieceIdx][i];
        backtrack(pieceIdx + 1, currentCombination);
    }
}

static int countCombinations(char** pieces, int piecesSize, char** positions, int positionsSize) {
    g_numPieces = piecesSize;
    g_totalValidCombinations = 0;

    // Initialize initialBoard
    for (int i = 0; i < 8; ++i) {
        for (int j = 0; j < 8; ++j) {
            g_initialBoard[i][j] = -1;
        }
    }

    // Parse input and populate g_pieces and g_initialBoard
    for (int i = 0; i < g_numPieces; ++i) {
        if (strcmp(pieces[i], "rook") == 0) {
            g_pieces[i].type = ROOK;
        } else if (strcmp(pieces[i], "queen") == 0) {
            g_pieces[i].type = QUEEN;
        } else { // bishop
            g_pieces[i].type = BISHOP;
        }
        g_pieces[i].start_pos = parsePosition(positions[i]);
        g_initialBoard[g_pieces[i].start_pos.r][g_pieces[i].start_pos.c] = i;
    }

    // Generate all potential moves for each piece
    for (int i = 0; i < g_numPieces; ++i) {
        generateMovesForPiece(i);
    }

    // Start backtracking
    Pos currentCombination[MAX_PIECES];
    backtrack(0, currentCombination);

    return g_totalValidCombinations;
}

int numberOfValidMoveCombinations(char** pieces, int piecesSize, char** positions, int positionsSize) {
    return countCombinations(pieces, piecesSize, positions, positionsSize);
}