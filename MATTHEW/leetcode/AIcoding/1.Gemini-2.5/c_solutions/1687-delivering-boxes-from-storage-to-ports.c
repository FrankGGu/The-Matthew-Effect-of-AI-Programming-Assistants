#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MAX

typedef struct {
    int* data;
    int head;
    int tail;
    int capacity;
} Deque;

void deque_init(Deque* dq, int capacity) {
    dq->data = (int*)malloc(sizeof(int) * capacity);
    dq->head = 0;
    dq->tail = -1;
    dq->capacity = capacity;
}

void deque_free(Deque* dq) {
    if (dq->data) {
        free(dq->data);
        dq->data = NULL;
    }
}

int deque_isEmpty(Deque* dq) {
    return dq->tail < dq->head;
}

void deque_push_back(Deque* dq, int val) {
    dq->tail++;
    dq->data[dq->tail] = val;
}

void deque_pop_back(Deque* dq) {
    if (!deque_isEmpty(dq)) {
        dq->tail--;
    }
}

int deque_back(Deque* dq) {
    return dq->data[dq->tail];
}

void deque_pop_front(Deque* dq) {
    if (!deque_isEmpty(dq)) {
        dq->head++;
    }
}

int deque_front(Deque* dq) {
    return dq->data[dq->head];
}

int deliverBoxes(int** boxes, int boxesSize, int* boxesColSize, int maxBoxes, long long maxWeight) {
    int n = boxesSize;

    // dp[i] = minimum cost to deliver boxes[0...i-1]
    // dp array size n+1 (dp[0] to dp[n])
    long long* dp = (long long*)malloc(sizeof(long long) * (n + 1));
    for (int i = 0; i <= n; ++i) {
        dp[i] = LLONG_MAX;
    }
    dp[0] = 0;

    // prefix_weight[k] = sum of weights of boxes[0...k-1]
    // prefix_weight array size n+1 (prefix_weight[0] to prefix_weight[n])
    long long* prefix_weight = (long long*)malloc(sizeof(long long) * (n + 1));
    prefix_weight[0] = 0;
    for (int i = 0; i < n; ++i) {
        prefix_weight[i+1] = prefix_weight[i] + boxes[i][1];
    }

    // PCC_for_dp[k] = number of port changes in boxes[0...k-1]
    // PCC_for_dp array size n+1 (PCC_for_dp[0] to PCC_for_dp[n])
    int* PCC_for_dp = (int*)malloc(sizeof(int) * (n + 1));
    PCC_for_dp[0] = 0;
    PCC_for_dp[1] = 0; // No port change for the first box (boxes[0])
    for (int i = 1; i < n; ++i) { // i is current box index (0-indexed)
        PCC_for_dp[i+1] = PCC_for_dp[i] + (boxes[i][0] != boxes[i-1][0] ? 1 : 0);
    }

    // val[j] = dp[j] - PCC_for_dp[j+1]
    // This array stores computed val_j values. Max index needed is n.
    // val array size n+1 (val[0] to val[n])
    long long* val = (long long*)malloc(sizeof(long long) * (n + 1));

    Deque dq;
    deque_init(&dq, n + 1); // Deque can store indices from 0 to n

    // Initialize for j=0
    // val[0] = dp[0] - PCC_for_dp[0+1] = dp[0] - PCC_for_dp[1] = 0 - 0 = 0
    val[0] = dp[0] - PCC_for_dp[1]; 
    deque_push_back(&dq, 0);

    int k_ptr = 0; // Leftmost valid starting index for a trip due to maxWeight constraint

    for (int i = 1; i <= n; ++i) { // i is the end index of the current trip (exclusive)
                                    // dp[i] is for boxes[0...i-1]
                                    // The current trip ends at boxes[i-1]
        // Adjust k_ptr for maxWeight constraint
        // Trip from boxes[k_ptr...i-1] must satisfy weight constraint
        // prefix_weight[i] - prefix_weight[k_ptr] <= maxWeight
        // prefix_weight[k_ptr] >= prefix_weight[i] - maxWeight
        while (k_ptr < i && prefix_weight[i] - prefix_weight[k_ptr] > maxWeight) {
            k_ptr++;
        }

        // Remove indices from front of deque that are too old
        // 1. Violate maxWeight constraint: j < k_ptr
        // 2. Violate maxBoxes constraint: j < i - maxBoxes
        while (!deque_isEmpty(&dq) && deque_front(&dq) < k_ptr) {
            deque_pop_front(&dq);
        }
        while (!deque_isEmpty(&dq) && deque_front(&dq) < i - maxBoxes) {
            deque_pop_front(&dq);
        }

        // Calculate dp[i] using the minimum val_j from the front of the deque
        // If deque is empty, it means no valid previous state, dp[i] remains LLONG_MAX
        if (!deque_isEmpty(&dq)) {
            dp[i] = 2 + PCC_for_dp[i] + val[deque_front(&dq)];
        }

        // Prepare for the next iteration: add i to the deque
        // Only add to deque if it can be a starting point for a future trip (i < n)
        if (i < n) { 
            // Calculate val[i] = dp[i] - PCC_for_dp[i+1]
            val[i] = dp[i] - PCC_for_dp[i+1];
            while (!deque_isEmpty(&dq) && val[deque_back(&dq)] >= val[i]) {
                deque_pop_back(&dq);
            }
            deque_push_back(&dq, i);
        }
    }

    long long result = dp[n];

    free(dp);
    free(prefix_weight);
    free(PCC_for_dp);
    free(val);
    deque_free(&dq);

    return (int)result;
}