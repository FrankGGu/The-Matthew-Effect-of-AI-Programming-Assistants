#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MAX

typedef struct DequeNode {
    int val;
    struct DequeNode* prev;
    struct DequeNode* next;
} DequeNode;

typedef struct {
    DequeNode* front;
    DequeNode* back;
    int size;
} Deque;

void init_deque(Deque* dq) {
    dq->front = NULL;
    dq->back = NULL;
    dq->size = 0;
}

void push_back(Deque* dq, int val) {
    DequeNode* newNode = (DequeNode*)malloc(sizeof(DequeNode));
    newNode->val = val;
    newNode->prev = dq->back;
    newNode->next = NULL;
    if (dq->back) {
        dq->back->next = newNode;
    } else {
        dq->front = newNode;
    }
    dq->back = newNode;
    dq->size++;
}

int pop_front(Deque* dq) {
    if (dq->size == 0) return -1; 
    int val = dq->front->val;
    DequeNode* temp = dq->front;
    dq->front = dq->front->next;
    if (dq->front) {
        dq->front->prev = NULL;
    } else {
        dq->back = NULL;
    }
    free(temp);
    dq->size--;
    return val;
}

int pop_back(Deque* dq) {
    if (dq->size == 0) return -1; 
    int val = dq->back->val;
    DequeNode* temp = dq->back;
    dq->back = dq->back->prev;
    if (dq->back) {
        dq->back->next = NULL;
    } else {
        dq->front = NULL;
    }
    free(temp);
    dq->size--;
    return val;
}

int front(Deque* dq) {
    return dq->front->val;
}

int back(Deque* dq) {
    return dq->back->val;
}

int is_empty(Deque* dq) {
    return dq->size == 0;
}

void free_deque(Deque* dq) {
    DequeNode* current = dq->front;
    while (current) {
        DequeNode* next = current->next;
        free(current);
        current = next;
    }
    dq->front = NULL;
    dq->back = NULL;
    dq->size = 0;
}

long long minimumCoins(int* prices, int pricesSize) {
    int n = pricesSize;
    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));
    if (!dp) return -1; 

    dp[0] = 0; // Cost to cover 0 fruits (fruits 0 to -1) is 0

    Deque dq;
    init_deque(&dq);

    // For dp[1] (cost to cover fruit 0), we must buy fruit 0.
    // So j=0 is a candidate. Add 0 to deque.
    // The value associated with j is dp[j] + prices[j].
    // dp[0] + prices[0] is the value for j=0.
    push_back(&dq, 0); 

    for (int i = 1; i <= n; ++i) {
        // Calculate left_bound for j for current i
        // j must be in [ceil((i-2)/2), i-1]
        // ceil((i-2)/2) can be calculated as (i-2 <= 0) ? 0 : (i-1)/2
        int left_bound = (i - 2 <= 0) ? 0 : (i - 1) / 2;

        // Remove elements from front of deque whose index j is less than left_bound
        while (!is_empty(&dq) && front(&dq) < left_bound) {
            pop_front(&dq);
        }

        // dp[i] is the minimum of (dp[j] + prices[j]) for j in the current window
        // The front of the deque has the index j that minimizes this value
        dp[i] = dp[front(&dq)] + prices[front(&dq)];

        // Add current index `i` as a candidate `j` for future `dp` values (i.e., for `dp[i+1]` etc.)
        // The value to compare for `j=i` is `dp[i] + prices[i]`.
        // Only add if `i` is a valid fruit index (i.e., `i < n`).
        if (i < n) { 
            long long current_j_val = dp[i] + prices[i];
            while (!is_empty(&dq) && (dp[back(&dq)] + prices[back(&dq)]) >= current_j_val) {
                pop_back(&dq);
            }
            push_back(&dq, i);
        }
    }

    long long result = dp[n];
    free(dp);
    free_deque(&dq);
    return result;
}