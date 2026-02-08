#include <stdlib.h>

typedef struct {
    int* arr;
    int front;
    int rear;
    int capacity;
    int size;
} Deque;

void deque_init(Deque* dq, int capacity) {
    dq->arr = (int*)malloc(sizeof(int) * capacity);
    dq->capacity = capacity;
    dq->front = 0;
    dq->rear = -1;
    dq->size = 0;
}

void deque_free(Deque* dq) {
    free(dq->arr);
}

int deque_isEmpty(Deque* dq) {
    return dq->size == 0;
}

int deque_front(Deque* dq) {
    return dq->arr[dq->front];
}

int deque_back(Deque* dq) {
    return dq->arr[dq->rear];
}

void deque_push_back(Deque* dq, int val) {
    dq->rear = (dq->rear + 1) % dq->capacity;
    dq->arr[dq->rear] = val;
    dq->size++;
}

void deque_pop_front(Deque* dq) {
    dq->front = (dq->front + 1) % dq->capacity;
    dq->size--;
}

void deque_pop_back(Deque* dq) {
    dq->rear = (dq->rear - 1 + dq->capacity) % dq->capacity;
    dq->size--;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumRobots(int* chargeTimes, int chargeTimesSize, int* runningCosts, int runningCostsSize, long long budget) {
    int n = chargeTimesSize;
    int left = 0;
    long long current_sum_running_cost = 0;
    int max_robots = 0;

    Deque dq;
    deque_init(&dq, n);

    for (int right = 0; right < n; ++right) {
        current_sum_running_cost += runningCosts[right];

        while (!deque_isEmpty(&dq) && chargeTimes[deque_back(&dq)] <= chargeTimes[right]) {
            deque_pop_back(&dq);
        }
        deque_push_back(&dq, right);

        while (!deque_isEmpty(&dq) && 
               (long long)chargeTimes[deque_front(&dq)] + (long long)(right - left + 1) * current_sum_running_cost > budget) {

            current_sum_running_cost -= runningCosts[left];

            if (deque_front(&dq) == left) {
                deque_pop_front(&dq);
            }

            left++;
        }

        // If the window is valid (left <= right), update max_robots
        if (left <= right) {
            max_robots = max(max_robots, right - left + 1);
        }
    }

    deque_free(&dq);

    return max_robots;
}