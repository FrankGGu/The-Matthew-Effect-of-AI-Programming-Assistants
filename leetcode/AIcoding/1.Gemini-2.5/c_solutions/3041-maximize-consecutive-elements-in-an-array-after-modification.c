#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

typedef struct {
    int* arr;
    int capacity;
    int head; // index of the first element
    int tail; // index of the next available slot
    int size;
} Deque;

void init_deque(Deque* dq, int capacity) {
    dq->arr = (int*)malloc(sizeof(int) * capacity);
    dq->capacity = capacity;
    dq->head = 0;
    dq->tail = 0;
    dq->size = 0;
}

void free_deque(Deque* dq) {
    free(dq->arr);
}

int is_deque_empty(Deque* dq) {
    return dq->size == 0;
}

void push_back(Deque* dq, int val) {
    dq->arr[dq->tail] = val;
    dq->tail = (dq->tail + 1) % dq->capacity;
    dq->size++;
}

int pop_front(Deque* dq) {
    int val = dq->arr[dq->head];
    dq->head = (dq->head + 1) % dq->capacity;
    dq->size--;
    return val;
}

int pop_back(Deque* dq) {
    dq->tail = (dq->tail - 1 + dq->capacity) % dq->capacity;
    int val = dq->arr[dq->tail];
    dq->size--;
    return val;
}

int front(Deque* dq) {
    return dq->arr[dq->head];
}

int back(Deque* dq) {
    return dq->arr[(dq->tail - 1 + dq->capacity) % dq->capacity];
}

int maxConsecutive(int* nums, int numsSize, int k) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), compare);

    Deque dq;
    init_deque(&dq, numsSize);

    long long current_sum = 0;
    int max_len = 0;
    int left = 0;

    for (int right = 0; right < numsSize; ++right) {
        current_sum += nums[right];

        // Maintain deque for max(nums[p] - p)
        // Store indices p
        while (!is_deque_empty(&dq) && (long long)nums[back(&dq)] - back(&dq) <= (long long)nums[right] - right) {
            pop_back(&dq);
        }
        push_back(&dq, right);

        long long len = right - left + 1;
        long long M_val = (long long)nums[front(&dq)] - front(&dq); // M = max_{p=left to right} (nums[p] - p)
        long long X_min = M_val + left; // Smallest X for the current window [left, right]

        // Cost = sum_{p=left to right} ( (X_min + (p-left)) - nums[p] )
        // Cost = len * X_min + sum_{p=left to right}(p-left) - current_sum
        // sum_{p=left to right}(p-left) = 0 + 1 + ... + (len-1) = (len-1)*len/2
        long long cost = len * X_min + (len - 1) * len / 2 - current_sum;

        while (cost > k) {
            // Shrink window from left
            current_sum -= nums[left];

            // Remove left from deque if it's the front
            // If len > 0, deque cannot be empty because 'right' is always pushed.
            // If front(&dq) == left, it means the element at 'left' was the maximum
            // (nums[p]-p) in the previous window, so it needs to be removed.
            if (front(&dq) == left) {
                pop_front(&dq);
            }
            left++;
            len = right - left + 1;

            // If len becomes 0 or less, the cost will be 0, so the while loop will terminate.
            // No need for explicit break.

            // Recalculate cost for the new window [left, right]
            // If len > 0, deque cannot be empty.
            M_val = (long long)nums[front(&dq)] - front(&dq);
            X_min = M_val + left;
            cost = len * X_min + (len - 1) * len / 2 - current_sum;
        }

        // After the while loop, cost <= k, so the current window [left, right] is valid
        // Update max_len
        if (len > max_len) {
            max_len = len;
        }
    }

    free_deque(&dq);
    return max_len;
}