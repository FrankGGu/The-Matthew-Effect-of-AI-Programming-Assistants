#include <stdlib.h>
#include <stdbool.h>

#define MAX_TARGET_VAL 10000

#define MAX_SPEED_LOG 15 

#define MIN_POS_FOR_VISITED (-MAX_TARGET_VAL)
#define MAX_POS_FOR_VISITED (MAX_TARGET_VAL + (1 << (MAX_SPEED_LOG - 1)))
#define POS_OFFSET (-MIN_POS_FOR_VISITED) // To map MIN_POS_FOR_VISITED to 0
#define VISITED_POS_RANGE (MAX_POS_FOR_VISITED - MIN_POS_FOR_VISITED + 1)

typedef struct {
    int pos;
    int speed_log_idx; // log2(abs(speed))
    int sign;          // 0 for positive speed, 1 for negative speed
    int steps;
} State;

bool visited[VISITED_POS_RANGE][MAX_SPEED_LOG][2];

State queue[VISITED_POS_RANGE * MAX_SPEED_LOG * 2]; // Max possible states
int head;
int tail;

int racecar(int target) {
    // Reset visited array for each test case
    for (int i = 0; i < VISITED_POS_RANGE; i++) {
        for (int j = 0; j < MAX_SPEED_LOG; j++) {
            visited[i][j][0] = false;
            visited[i][j][1] = false;
        }
    }

    head = 0;
    tail = 0;

    // Initial state: (pos=0, speed=1, steps=0)
    // speed=1 means speed_log_idx=0, sign=0 (positive)
    State initial_state = {0, 0, 0, 0};
    queue[tail++] = initial_state;
    visited[0 + POS_OFFSET][0][0] = true;

    while (head < tail) {
        State current = queue[head++];

        if (current.pos == target) {
            return current.steps;
        }

        // Calculate actual speed from log_idx and sign
        int current_speed_abs = (1 << current.speed_log_idx);
        int current_speed = (current.sign == 0) ? current_speed_abs : -current_speed_abs;

        // Option 1: Accelerate ('A')
        int next_pos_A = current.pos + current_speed;
        int next_speed_log_idx_A = current.speed_log_idx + 1;
        int next_sign_A = current.sign; // Speed sign doesn't change with 'A'

        // Check bounds for next_speed_log_idx_A
        if (next_speed_log_idx_A < MAX_SPEED_LOG) {
            // Check if state is valid and not visited
            int next_pos_A_idx = next_pos_A + POS_OFFSET;
            if (next_pos_A_idx >= 0 && next_pos_A_idx < VISITED_POS_RANGE && 
                !visited[next_pos_A_idx][next_speed_log_idx_A][next_sign_A]) {

                visited[next_pos_A_idx][next_speed_log_idx_A][next_sign_A] = true;
                State next_state_A = {next_pos_A, next_speed_log_idx_A, next_sign_A, current.steps + 1};
                queue[tail++] = next_state_A;
            }
        }

        // Option 2: Reverse ('R')
        int next_pos_R = current.pos; // Position doesn't change
        int next_speed_log_idx_R = 0; // Speed becomes 1 (log_idx 0)
        int next_sign_R;
        if (current_speed > 0) { // If current speed was positive, new speed is -1 (sign 1)
            next_sign_R = 1;
        } else { // If current speed was negative, new speed is 1 (sign 0)
            next_sign_R = 0;
        }

        // Check if state is valid and not visited
        int next_pos_R_idx = next_pos_R + POS_OFFSET;
        if (next_pos_R_idx >= 0 && next_pos_R_idx < VISITED_POS_RANGE && 
            !visited[next_pos_R_idx][next_speed_log_idx_R][next_sign_R]) {

            visited[next_pos_R_idx][next_speed_log_idx_R][next_sign_R] = true;
            State next_state_R = {next_pos_R, next_speed_log_idx_R, next_sign_R, current.steps + 1};
            queue[tail++] = next_state_R;
        }
    }
    return -1; // Should not be reached for valid targets
}