#include <stdlib.h> // For malloc and free

typedef struct {
    int* arr;
    int capacity;
    int head;
    int tail;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->arr = (int*)malloc(capacity * sizeof(int));
    dq->capacity = capacity;
    dq->head = 0;
    dq->tail = 0;
    return dq;
}

void freeDeque(Deque* dq) {
    free(dq->arr);
    free(dq);
}

int isEmpty(Deque* dq) {
    return dq->head == dq->tail;
}

void push_back(Deque* dq, int val) {
    dq->arr[dq->tail] = val;
    dq->tail = (dq->tail + 1) % dq->capacity;
}

void pop_front(Deque* dq) {
    dq->head = (dq->head + 1) % dq->capacity;
}

void pop_back(Deque* dq) {
    dq->tail = (dq->tail - 1 + dq->capacity) % dq->capacity;
}

int get_front(Deque* dq) {
    return dq->arr[dq->head];
}

int get_back(Deque* dq) {
    return dq->arr[(dq->tail - 1 + dq->capacity) % dq->capacity];
}

int maxResult(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return nums[0];
    }

    // The nums array will be used to store the maximum scores to reach each index.
    // nums[i] will effectively become dp[i].

    // Deque stores indices, maintaining them in decreasing order of their corresponding
    // scores in the nums array (which are dp values).
    // The deque capacity should be at least k+1, but numsSize is a safe upper bound.
    Deque* dq = createDeque(numsSize);

    // Initialize for the starting position (index 0)
    // The score to reach index 0 is nums[0] itself.
    push_back(dq, 0);

    // Iterate from the second element to the last
    for (int i = 1; i < numsSize; i++) {
        // Remove indices from the front of the deque if they are out of the k-window.
        // An index 'j' is out of window if 'j < i - k'.
        while (!isEmpty(dq) && get_front(dq) < i - k) {
            pop_front(dq);
        }

        // The maximum score to reach index 'i' is nums[i] plus the maximum score
        // from a reachable previous index within the k-window.
        // The front of the deque always holds the index with the maximum score
        // within the current window.
        nums[i] += nums[get_front(dq)];

        // Remove indices from the back of the deque whose scores are less than or
        // equal to the current score (nums[i]). This maintains the decreasing
        // order of scores in the deque.
        while (!isEmpty(dq) && nums[get_back(dq)] <= nums[i]) {
            pop_back(dq);
        }

        // Add the current index 'i' to the back of the deque.
        push_back(dq, i);
    }

    // The maximum score to reach the last index (numsSize - 1) is the answer.
    int result = nums[numsSize - 1];

    // Free the allocated memory for the deque.
    freeDeque(dq);

    return result;
}