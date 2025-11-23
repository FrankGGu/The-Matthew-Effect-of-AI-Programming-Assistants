#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUEUE_SIZE 10000

typedef struct {
    int state;
    int steps;
} QueueNode;

int openLock(char ** deadends, int deadendsSize, char * target) {
    int visited[10000] = {0};
    int target_state = atoi(target);

    for (int i = 0; i < deadendsSize; i++) {
        visited[atoi(deadends[i])] = 1;
    }

    if (visited[0]) {
        return -1;
    }

    QueueNode queue[MAX_QUEUE_SIZE];
    int head = 0;
    int tail = 0;

    queue[tail].state = 0;
    queue[tail].steps = 0;
    tail++;
    visited[0] = 1;

    while (head < tail) {
        QueueNode current = queue[head++];

        if (current.state == target_state) {
            return current.steps;
        }

        for (int i = 0; i < 4; i++) {
            int digit = (current.state / (int)pow(10, i)) % 10;

            int next_state_plus = current.state + (int)pow(10, i) * ((digit == 9) ? -9 : 1);
            if (!visited[next_state_plus]) {
                visited[next_state_plus] = 1;
                queue[tail].state = next_state_plus;
                queue[tail].steps = current.steps + 1;
                tail++;
            }

            int next_state_minus = current.state - (int)pow(10, i) * ((digit == 0) ? -9 : 1);
            if (!visited[next_state_minus]) {
                visited[next_state_minus] = 1;
                queue[tail].state = next_state_minus;
                queue[tail].steps = current.steps + 1;
                tail++;
            }
        }
    }

    return -1;
}