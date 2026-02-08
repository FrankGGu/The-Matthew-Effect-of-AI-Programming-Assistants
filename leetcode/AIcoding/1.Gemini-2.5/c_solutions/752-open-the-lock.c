#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_STATES 10000

int queue[MAX_STATES];
int head_ptr = 0;
int tail_ptr = 0;

bool visited[MAX_STATES];

int distance[MAX_STATES];

static int str_to_int(char* s) {
    return (s[0] - '0') * 1000 + (s[1] - '0') * 100 + (s[2] - '0') * 10 + (s[3] - '0');
}

static void int_to_str(int n, char* buffer) {
    buffer[3] = (n % 10) + '0';
    n /= 10;
    buffer[2] = (n % 10) + '0';
    n /= 10;
    buffer[1] = (n % 10) + '0';
    n /= 10;
    buffer[0] = (n % 10) + '0';
    buffer[4] = '\0';
}

static void enqueue(int val, int dist) {
    queue[tail_ptr] = val;
    distance[val] = dist;
    visited[val] = true;
    tail_ptr = (tail_ptr + 1) % MAX_STATES;
}

static int dequeue() {
    int val = queue[head_ptr];
    head_ptr = (head_ptr + 1) % MAX_STATES;
    return val;
}

static bool is_empty() {
    return head_ptr == tail_ptr;
}

int openLock(char** deadends, int deadendsSize, char* target) {
    head_ptr = 0;
    tail_ptr = 0;
    for (int i = 0; i < MAX_STATES; ++i) {
        visited[i] = false;
        distance[i] = -1;
    }

    for (int i = 0; i < deadendsSize; ++i) {
        int dead_val = str_to_int(deadends[i]);
        visited[dead_val] = true;
    }

    int target_val = str_to_int(target);
    int start_val = 0; // "0000"

    if (visited[start_val]) {
        return -1;
    }

    enqueue(start_val, 0);

    while (!is_empty()) {
        int curr_val = dequeue();
        int curr_dist = distance[curr_val];

        if (curr_val == target_val) {
            return curr_dist;
        }

        char curr_s[5];
        int_to_str(curr_val, curr_s);

        for (int i = 0; i < 4; ++i) {
            char original_char = curr_s[i];

            curr_s[i] = (original_char == '9') ? '0' : (original_char + 1);
            int next_val_up = str_to_int(curr_s);
            if (!visited[next_val_up]) {
                enqueue(next_val_up, curr_dist + 1);
            }

            curr_s[i] = (original_char == '0') ? '9' : (original_char - 1);
            int next_val_down = str_to_int(curr_s);
            if (!visited[next_val_down]) {
                enqueue(next_val_down, curr_dist + 1);
            }

            curr_s[i] = original_char;
        }
    }

    return -1;
}