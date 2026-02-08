#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_COMBINATIONS 10000

typedef struct {
    char code[5]; // 4 digits + null terminator
    int dist;
} State;

int code_to_int(const char* code) {
    return (code[0] - '0') * 1000 +
           (code[1] - '0') * 100 +
           (code[2] - '0') * 10 +
           (code[3] - '0');
}

int openLock(char** deadends, int deadendsSize, char* target) {
    // Array to keep track of visited states, indexed by integer representation of code
    bool visited[MAX_COMBINATIONS] = {false};
    // Array to mark deadend states
    bool is_deadend[MAX_COMBINATIONS] = {false};

    // Populate the deadend array
    for (int i = 0; i < deadendsSize; i++) {
        is_deadend[code_to_int(deadends[i])] = true;
    }

    // Check if the initial state "0000" is a deadend
    if (is_deadend[0]) {
        return -1;
    }

    // BFS Queue implementation using a static array
    State queue[MAX_COMBINATIONS];
    int head = 0; // Front of the queue
    int tail = 0; // End of the queue

    // Initialize the starting state "0000"
    State initial_state;
    strcpy(initial_state.code, "0000");
    initial_state.dist = 0;

    // Add initial state to the queue and mark as visited
    queue[tail++] = initial_state;
    visited[0] = true;

    // Convert target to integer for quicker comparison later if needed,
    // but strcmp is also fine as it's only for the final check.
    // int target_int = code_to_int(target);

    while (head < tail) {
        State current = queue[head++]; // Dequeue current state

        // If current code matches the target, we found the shortest path
        if (strcmp(current.code, target) == 0) {
            return current.dist;
        }

        // Generate all 8 possible next states (spinning each of the 4 digits up or down)
        for (int i = 0; i < 4; i++) { // For each of the 4 digits
            char original_digit = current.code[i]; // Store the original digit

            // Spin digit up
            current.code[i] = (original_digit == '9') ? '0' : original_digit + 1;
            int next_code_int_up = code_to_int(current.code);
            if (!visited[next_code_int_up] && !is_deadend[next_code_int_up]) {
                visited[next_code_int_up] = true;
                State next_state_up;
                strcpy(next_state_up.code, current.code); // Copy the modified code
                next_state_up.dist = current.dist + 1;
                queue[tail++] = next_state_up; // Enqueue
            }

            // Restore the digit to its original value before spinning down
            current.code[i] = original_digit;

            // Spin digit down
            current.code[i] = (original_digit == '0') ? '9' : original_digit - 1;
            int next_code_int_down = code_to_int(current.code);
            if (!visited[next_code_int_down] && !is_deadend[next_code_int_down]) {
                visited[next_code_int_down] = true;
                State next_state_down;
                strcpy(next_state_down.code, current.code); // Copy the modified code
                next_state_down.dist = current.dist + 1;
                queue[tail++] = next_state_down; // Enqueue
            }

            // Restore the digit to its original value for the next iteration of 'i'
            // (This is important because 'current' is a local copy and its 'code' is modified in place)
            current.code[i] = original_digit;
        }
    }

    // If the queue becomes empty and the target was not reached, it's unreachable
    return -1;
}