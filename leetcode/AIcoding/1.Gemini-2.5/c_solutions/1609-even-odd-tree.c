#include <stdbool.h>
#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_QUEUE_SIZE 100001

struct TreeNode* queue_arr[MAX_QUEUE_SIZE];
int queue_front_idx = 0;
int queue_rear_idx = 0;

void queue_init() {
    queue_front_idx = 0;
    queue_rear_idx = 0;
}

void enqueue(struct TreeNode* node) {
    queue_arr[queue_rear_idx] = node;
    queue_rear_idx = (queue_rear_idx + 1) % MAX_QUEUE_SIZE;
}

struct TreeNode* dequeue() {
    struct TreeNode* node = queue_arr[queue_front_idx];
    queue_front_idx = (queue_front_idx + 1) % MAX_QUEUE_SIZE;
    return node;
}

bool is_queue_empty() {
    return queue_front_idx == queue_rear_idx;
}

int get_queue_current_size() {
    return (queue_rear_idx - queue_front_idx + MAX_QUEUE_SIZE) % MAX_QUEUE_SIZE;
}

bool isEvenOddTree(struct TreeNode* root) {
    if (root == NULL) {
        return true;
    }

    queue_init();
    enqueue(root);
    int level = 0;

    while (!is_queue_empty()) {
        int level_size = get_queue_current_size();
        int prev_val;

        if (level % 2 == 0) { // Even level: odd values, strictly increasing
            prev_val = INT_MIN;
        } else { // Odd level: even values, strictly decreasing
            prev_val = INT_MAX;
        }

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* curr = dequeue();

            if (level % 2 == 0) { // Even level
                if (curr->val % 2 == 0) { // Must be odd
                    return false;
                }
                if (curr->val <= prev_val) { // Must be strictly increasing
                    return false;
                }
            } else { // Odd level
                if (curr->val % 2 != 0) { // Must be even
                    return false;
                }
                if (curr->val >= prev_val) { // Must be strictly decreasing
                    return false;
                }
            }
            prev_val = curr->val;

            if (curr->left != NULL) {
                enqueue(curr->left);
            }
            if (curr->right != NULL) {
                enqueue(curr->right);
            }
        }
        level++;
    }

    return true;
}