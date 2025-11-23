#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define MAX_COORD 8000

typedef struct {
    int pos;
    int last_dir; // 0 for forward jump, 1 for backward jump
    int jumps;
} State;

State queue[MAX_COORD * 2]; // Max states: MAX_COORD positions * 2 directions
int head = 0;
int tail = 0;

void enqueue(int pos, int last_dir, int jumps) {
    queue[tail].pos = pos;
    queue[tail].last_dir = last_dir;
    queue[tail].jumps = jumps;
    tail++;
}

State dequeue() {
    return queue[head++];
}

bool is_queue_empty() {
    return head == tail;
}

bool visited[MAX_COORD][2];

bool is_forbidden[MAX_COORD];

int minimumJumps(int* forbidden, int forbiddenSize, int a, int b, int x) {
    // Reset global variables for each test case
    head = 0;
    tail = 0;
    memset(visited, 0, sizeof(visited));
    memset(is_forbidden, 0, sizeof(is_forbidden));

    // Mark forbidden positions
    for (int i = 0; i < forbiddenSize; i++) {
        if (forbidden[i] < MAX_COORD) { // Only mark if within our exploration range
            is_forbidden[forbidden[i]] = true;
        }
    }

    // Initial state: (pos=0, last_dir=0, jumps=0)
    // last_dir=0 represents either initial state or previous jump was forward.
    // This allows us to jump backward from 0.
    enqueue(0, 0, 0);
    visited[0][0] = true; // Mark (0, arrived by forward/initial) as visited

    while (!is_queue_empty()) {
        State current = dequeue();

        // If target reached, return jumps
        if (current.pos == x) {
            return current.jumps;
        }

        // Option 1: Jump forward (current.pos + a)
        int next_pos_f = current.pos + a;
        // Check bounds, not forbidden, and not visited with 'arrived by forward' state
        if (next_pos_f < MAX_COORD && !is_forbidden[next_pos_f] && !visited[next_pos_f][0]) {
            visited[next_pos_f][0] = true;
            enqueue(next_pos_f, 0, current.jumps + 1);
        }

        // Option 2: Jump backward (current.pos - b)
        // Cannot jump backward twice in a row (current.last_dir == 1)
        // Must be non-negative
        // Not forbidden
        // Not visited with 'arrived by backward' state
        if (current.last_dir != 1) { // If previous jump was not backward
            int next_pos_b = current.pos - b;
            if (next_pos_b >= 0 && !is_forbidden[next_pos_b] && !visited[next_pos_b][1]) {
                visited[next_pos_b][1] = true;
                enqueue(next_pos_b, 1, current.jumps + 1);
            }
        }
    }

    // Target not reachable
    return -1;
}