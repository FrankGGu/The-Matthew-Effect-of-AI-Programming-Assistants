#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MIN

typedef struct {
    int* data;
    int head; // index of the front element
    int tail; // index of the last element
    int capacity;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(sizeof(int) * capacity);
    dq->head = 0;
    dq->tail = -1; // tail points to the last element, -1 means empty
    dq->capacity = capacity;
    return dq;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int isEmpty(Deque* dq) {
    return dq->head > dq->tail;
}

void pushBack(Deque* dq, int val) {
    dq->data[++dq->tail] = val;
}

int popFront(Deque* dq) {
    return dq->data[dq->head++];
}

int peekFront(Deque* dq) {
    return dq->data[dq->head];
}

int popBack(Deque* dq) {
    return dq->data[dq->tail--];
}

int peekBack(Deque* dq) {
    return dq->data[dq->tail];
}

int findMaxValueOfEquation(int** points, int pointsSize, int* pointsColSize, int k) {
    int max_val = INT_MIN; // Initialize with the smallest possible integer value

    Deque* dq = createDeque(pointsSize); // Deque to store indices

    for (int j = 0; j < pointsSize; ++j) {
        int xj = points[j][0];
        int yj = points[j][1];

        // 1. Remove indices 'i' from the front of the deque if they are too far from 'j'
        // Condition: xj - xi > k  =>  xi < xj - k
        while (!isEmpty(dq) && points[peekFront(dq)][0] < xj - k) {
            popFront(dq);
        }

        // 2. If the deque is not empty, calculate the equation value with the best 'i'
        // The best 'i' is at the front of the deque because it has the maximum (yi - xi)
        if (!isEmpty(dq)) {
            int i = peekFront(dq);
            // Equation: yi + yj + |xi - xj|
            // Since xi < xj, |xi - xj| = xj - xi
            // So, the equation becomes: yi + yj + xj - xi
            // Rearranged: (yj + xj) + (yi - xi)
            int current_val = (yj + xj) + (points[i][1] - points[i][0]);
            if (current_val > max_val) {
                max_val = current_val;
            }
        }

        // 3. Add current index 'j' to the back of the deque
        // Maintain the property that (yi - xi) values are in decreasing order from front to back
        // If current (yj - xj) is greater than or equal to (yi - xi) of the last element in deque,
        // the last element is no longer useful (it's older and provides a worse or equal (y-x) value).
        while (!isEmpty(dq) && (points[peekBack(dq)][1] - points[peekBack(dq)][0]) <= (yj - xj)) {
            popBack(dq);
        }
        pushBack(dq, j);
    }

    freeDeque(dq); // Clean up allocated memory
    return max_val;
}