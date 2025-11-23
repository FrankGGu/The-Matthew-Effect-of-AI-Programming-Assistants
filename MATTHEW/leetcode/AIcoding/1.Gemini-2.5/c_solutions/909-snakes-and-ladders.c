#include <stdbool.h>
#include <stdlib.h> // For malloc, free, calloc

typedef struct {
    int square;
    int moves;
} QueueNode;

#define MAX_SQUARES 401 
QueueNode queue[MAX_SQUARES];
int head = 0;
int tail = 0;

void enqueue(int square, int moves) {
    queue[tail].square = square;
    queue[tail].moves = moves;
    tail++;
}

QueueNode dequeue() {
    return queue[head++];
}

bool is_empty() {
    return head == tail;
}

int get_board_value(int s, int n, int** board) {
    // s is a 1-indexed square number (1 to n*n)
    // Convert s to a 0-indexed flat index
    int flat_idx = s - 1;

    // Determine the row index relative to the bottom of the board (0-indexed)
    // e.g., bottom row is 0, second from bottom is 1, etc.
    int r_from_bottom_idx = flat_idx / n;

    // Determine the actual row index in the 2D array (0-indexed from top)
    int actual_r = (n - 1) - r_from_bottom_idx;

    // Determine the actual column index in the 2D array (0-indexed from left)
    int actual_c;
    if (r_from_bottom_idx % 2 == 0) { 
        // If it's an even row from the bottom (e.g., bottom-most, or 3rd from bottom),
        // the squares are laid out left-to-right.
        actual_c = flat_idx % n;
    } else { 
        // If it's an odd row from the bottom (e.g., 2nd from bottom, or 4th from bottom),
        // the squares are laid out right-to-left.
        actual_c = (n - 1) - (flat_idx % n);
    }

    return board[actual_r][actual_c];
}

int snakesAndLadders(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int total_squares = n * n;

    // Initialize visited array for 1-indexed squares
    bool* visited = (bool*)calloc(total_squares + 1, sizeof(bool));
    if (visited == NULL) {
        // Handle potential memory allocation failure
        return -1; 
    }

    // Reset queue for each function call
    head = 0;
    tail = 0;

    // Start BFS from square 1 with 0 moves
    enqueue(1, 0);
    visited[1] = true;

    while (!is_empty()) {
        QueueNode current = dequeue();
        int current_square = current.square;
        int moves = current.moves;

        // If we reached the target square, return the number of moves
        if (current_square == total_squares) {
            free(visited);
            return moves;
        }

        // Simulate rolling a dice (1 to 6)
        for (int dice_roll = 1; dice_roll <= 6; ++dice_roll) {
            int next_square = current_square + dice_roll;

            // Ensure we don't go beyond the board
            if (next_square > total_squares) {
                continue;
            }

            // Check if the next_square has a snake or ladder
            int board_val = get_board_value(next_square, n, board);
            int final_next_square = (board_val != -1) ? board_val : next_square;

            // If the final destination square has not been visited, enqueue it
            if (!visited[final_next_square]) {
                visited[final_next_square] = true;
                enqueue(final_next_square, moves + 1);
            }
        }
    }

    // If the loop finishes, it means the target square is not reachable
    free(visited);
    return -1;
}