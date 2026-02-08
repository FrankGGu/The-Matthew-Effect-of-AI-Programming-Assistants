#include <stdbool.h> // For bool type
#include <stdlib.h>  // For abs()
#include <string.h>  // For memset()

#define MAX_TARGET 10000
#define MAX_POS (MAX_TARGET * 2 + 1) // Max position can be 20000. Array size 20001.

#define MAX_SPEED_EXP 16 // Covers exponents 0 to 15 (2^0 to 2^(MAX_SPEED_EXP-1))
#define SPEED_OFFSET MAX_SPEED_EXP // Offset for negative speeds
#define MAX_SPEED_IDX (MAX_SPEED_EXP * 2) // Total indices for positive and negative speeds

typedef struct {
    int pos;
    int speed;
    int steps;
} State;

#define QUEUE_CAPACITY (MAX_POS * MAX_SPEED_IDX)
State queue[QUEUE_CAPACITY];
int head = 0;
int tail = 0;

void enqueue(State s) {
    queue[tail++] = s;
}

State dequeue() {
    return queue[head++];
}

bool is_queue_empty() {
    return head == tail;
}

bool visited[MAX_POS][MAX_SPEED_IDX];

int get_speed_idx(int speed) {
    int k = __builtin_ctz(abs(speed));
    return (speed > 0) ? k : k + SPEED_OFFSET;
}

int racecar(int target) {
    // Reset queue pointers and visited array for each test case
    head = 0;
    tail = 0;
    // Initialize visited array to all false
    memset(visited, 0, sizeof(visited));

    // Initial state: (position 0, speed 1, 0 steps)
    State initial_state = {0, 1, 0};
    enqueue(initial_state);
    visited[0][get_speed_idx(1)] = true;

    // BFS loop
    while (!is_queue_empty()) {
        State current = dequeue();

        // If current position is the target, we found the shortest path
        if (current.pos == target) {
            return current.steps;
        }

        // --- Option 1: Accelerate ('A') ---
        int next_pos_A = current.pos + current.speed;
        int next_speed_A = current.speed * 2;
        int next_steps_A = current.steps + 1;

        // Calculate the exponent for the new speed.
        // __builtin_ctz(abs(next_speed_A)) gives log2(abs(next_speed_A)).
        int next_speed_exp_A = __builtin_ctz(abs(next_speed_A));

        // Pruning conditions for 'A' operation:
        // 1. Position must be within valid bounds [0, MAX_POS-1].
        //    Going too far past target (e.g., > 2*target) is usually suboptimal.
        //    Going negative is also usually suboptimal unless we just reversed.
        // 2. Speed exponent must be within valid bounds [0, MAX_SPEED_EXP-1].
        //    If speed becomes 2^16 or higher, it's too fast and likely to overshoot.
        if (next_pos_A >= 0 && next_pos_A < MAX_POS && next_speed_exp_A < MAX_SPEED_EXP) {
            int next_speed_idx_A = get_speed_idx(next_speed_A);
            if (!visited[next_pos_A][next_speed_idx_A]) {
                visited[next_pos_A][next_speed_idx_A] = true;
                enqueue((State){next_pos_A, next_speed_A, next_steps_A});
            }
        }

        // --- Option 2: Reverse ('R') ---
        int next_pos_R = current.pos; // Position remains the same
        int next_speed_R = (current.speed > 0) ? -1 : 1; // Reverse direction, speed becomes 1 or -1
        int next_steps_R = current.steps + 1;

        // For 'R' operation:
        // Position `next_pos_R` is `current.pos`, which was already checked to be within `[0, MAX_POS)` when it was enqueued.
        // Speed `next_speed_R` is always `1` or `-1`, meaning its exponent is `0`, which is always within `MAX_SPEED_EXP`.
        int next_speed_idx_R = get_speed_idx(next_speed_R);
        if (!visited[next_pos_R][next_speed_idx_R]) {
            visited[next_pos_R][next_speed_idx_R] = true;
            enqueue((State){next_pos_R, next_speed_R, next_steps_R});
        }
    }

    return -1; // Should theoretically not be reached as a solution always exists.
}