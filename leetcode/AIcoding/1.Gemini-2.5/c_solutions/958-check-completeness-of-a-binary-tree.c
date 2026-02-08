#include <stdbool.h>

#define MAX_QUEUE_CAPACITY 200005 

struct TreeNode* global_queue[MAX_QUEUE_CAPACITY];
int global_front = 0;
int global_rear = 0;

void queue_init() {
    global_front = 0;
    global_rear = 0;
}

void queue_enqueue(struct TreeNode* node) {
    global_queue[global_rear++] = node;
}

struct TreeNode* queue_dequeue() {
    return global_queue[global_front++];
}

bool queue_is_empty() {
    return global_front == global_rear;
}

bool isCompleteTree(struct TreeNode* root) {
    if (root == NULL) {
        return true;
    }

    queue_init();
    queue_enqueue(root);

    bool null_encountered = false;

    while (!queue_is_empty()) {
        struct TreeNode* current = queue_dequeue();

        if (current == NULL) {
            null_encountered = true;
        } else {
            if (null_encountered) {
                return false;
            }
            queue_enqueue(current->left);
            queue_enqueue(current->right);
        }
    }

    return true;
}