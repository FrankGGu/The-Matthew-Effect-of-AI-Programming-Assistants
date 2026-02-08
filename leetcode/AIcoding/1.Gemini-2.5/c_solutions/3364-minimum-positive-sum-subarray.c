#include <stdlib.h>
#include <limits.h>
#include <time.h> // For srand

typedef struct TreapNode {
    long long key;
    int priority;
    struct TreapNode *left, *right;
} TreapNode;

TreapNode* newTreapNode(long long key) {
    TreapNode* node = (TreapNode*)malloc(sizeof(TreapNode));
    node->key = key;
    node->priority = rand(); // Assign a random priority
    node->left = node->right = NULL;
    return node;
}

void split(TreapNode* T, long long split_key, TreapNode** L, TreapNode** R) {
    if (!T) {
        *L = *R = NULL;
        return;
    }
    if (T->key < split_key) {
        split(T->right, split_key, &(T->right), R);
        *L = T;
    } else {
        split(T->left, split_key, L, &(T->left));
        *R = T;
    }
}

TreapNode* merge(TreapNode* L, TreapNode* R) {
    if (!L) return R;
    if (!R) return L;

    if (L->priority > R->priority) {
        L->right = merge(L->right, R);
        return L;
    } else {
        R->left = merge(L, R->left);
        return R;
    }
}

TreapNode* insert(TreapNode* T, long long key) {
    TreapNode *L, *R, *newNode;
    split(T, key, &L, &R); // Split T into L (keys < key) and R (keys >= key)
    newNode = newTreapNode(key);
    return merge(merge(L, newNode), R); // Merge L, newNode, and R
}

long long find_largest_less_than(TreapNode* T, long long target_key) {
    long long result = LLONG_MIN;
    while (T) {
        if (T->key < target_key) {
            result = T->key; // Found a candidate, try to find a larger one in the right subtree
            T = T->right;
        } else {
            T = T->left; // Current key is too large or equal, go left
        }
    }
    return result;
}

void freeTreap(TreapNode* T) {
    if (T) {
        freeTreap(T->left);
        freeTreap(T->right);
        free(T);
    }
}

int minimumPositiveSumSubarray(int* nums, int numsSize) {
    // Seed the random number generator for Treap priorities
    srand(time(NULL));

    long long min_positive_sum = LLONG_MAX;
    long long current_sum = 0;

    // Initialize Treap with 0 for the empty prefix sum
    TreapNode* prefix_sums_treap = NULL;
    prefix_sums_treap = insert(prefix_sums_treap, 0);

    for (int i = 0; i < numsSize; ++i) {
        current_sum += nums[i];

        // Find the largest prefix sum (prev_sum) in the Treap such that prev_sum < current_sum
        long long prev_sum = find_largest_less_than(prefix_sums_treap, current_sum);

        if (prev_sum != LLONG_MIN) { // If such a prev_sum exists
            long long diff = current_sum - prev_sum;
            if (diff > 0) {
                if (diff < min_positive_sum) {
                    min_positive_sum = diff;
                }
            }
        }

        // Add the current_sum to the Treap
        prefix_sums_treap = insert(prefix_sums_treap, current_sum);
    }

    freeTreap(prefix_sums_treap); // Free allocated memory

    return (int)min_positive_sum;
}