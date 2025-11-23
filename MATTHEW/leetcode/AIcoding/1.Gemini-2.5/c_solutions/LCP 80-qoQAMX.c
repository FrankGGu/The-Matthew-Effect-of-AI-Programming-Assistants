#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_STATES 65536
#define MAX_QUEUE_SIZE MAX_STATES

typedef struct {
    int state;
    int steps;
} QueueNode;

typedef struct {
    QueueNode nodes[MAX_QUEUE_SIZE];
    int front;
    int rear;
    int size;
} Queue;

void initQueue(Queue* q) {
    q->front = 0;
    q->rear = -1;
    q->size = 0;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void enqueue(Queue* q, int state, int steps) {
    q->rear = (q->rear + 1) % MAX_QUEUE_SIZE;
    q->nodes[q->rear].state = state;
    q->nodes[q->rear].steps = steps;
    q->size++;
}

QueueNode dequeue(Queue* q) {
    QueueNode node = q->nodes[q->front];
    q->front = (q->front + 1) % MAX_QUEUE_SIZE;
    q->size--;
    return node;
}

int char_to_int_map(char c) {
    switch (c) {
        case 'A': return 0;
        case 'C': return 1;
        case 'G': return 2;
        case 'T': return 3;
        default: return -1;
    }
}

int string_to_int_representation(char* s, int N) {
    int res = 0;
    for (int i = 0; i < N; ++i) {
        res = (res << 2) | char_to_int_map(s[i]);
    }
    return res;
}

bool visited[MAX_STATES];

int minMutation(char* start, char* target, char** gene, int* pos, int geneSize) {
    int N = strlen(start);

    int start_int = string_to_int_representation(start, N);
    int target_int = string_to_int_representation(target, N);

    if (start_int == target_int) {
        return 0;
    }

    memset(visited, 0, sizeof(visited));

    Queue q;
    initQueue(&q);

    enqueue(&q, start_int, 0);
    visited[start_int] = true;

    while (!isEmpty(&q)) {
        QueueNode current = dequeue(&q);
        int current_state_int = current.state;
        int current_steps = current.steps;

        for (int i = 0; i < geneSize; ++i) {
            int p = pos[i];
            int from_char_int = char_to_int_map(gene[i][0]);
            int to_char_int = char_to_int_map(gene[i][1]);

            int char_at_p_int = (current_state_int >> (2 * (N - 1 - p))) & 0b11;

            if (char_at_p_int == from_char_int) {
                int next_state_int;
                int mask_clear_p = ~((0b11) << (2 * (N - 1 - p)));
                next_state_int = current_state_int & mask_clear_p;
                next_state_int |= (to_char_int << (2 * (N - 1 - p)));

                if (!visited[next_state_int]) {
                    if (next_state_int == target_int) {
                        return current_steps + 1;
                    }
                    visited[next_state_int] = true;
                    enqueue(&q, next_state_int, current_steps + 1);
                }
            }
        }
    }

    return -1;
}