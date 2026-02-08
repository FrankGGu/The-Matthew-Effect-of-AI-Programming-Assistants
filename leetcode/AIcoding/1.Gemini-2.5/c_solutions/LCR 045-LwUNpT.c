#define MAX_QUEUE_SIZE 10001

struct TreeNode* queue_storage[MAX_QUEUE_SIZE];
int queue_head = 0;
int queue_tail = 0;

void enqueue(struct TreeNode* node) {
    queue_storage[queue_tail] = node;
    queue_tail = (queue_tail + 1) % MAX_QUEUE_SIZE;
}

struct TreeNode* dequeue() {
    struct TreeNode* node = queue_storage[queue_head];
    queue_head = (queue_head + 1) % MAX_QUEUE_SIZE;
    return node;
}

int is_queue_empty() {
    return queue_head == queue_tail;
}

int get_queue_current_size() {
    return (queue_tail - queue_head + MAX_QUEUE_SIZE) % MAX_QUEUE_SIZE;
}

int findBottomLeftValue(struct TreeNode* root) {
    queue_head = 0;
    queue_tail = 0;

    enqueue(root);
    int bottomLeftValue = root->val;

    while (!is_queue_empty()) {
        int levelSize = get_queue_current_size();

        bottomLeftValue = queue_storage[queue_head]->val;

        for (int i = 0; i < levelSize; ++i) {
            struct TreeNode* current = dequeue();

            if (current->left != NULL) {
                enqueue(current->left);
            }
            if (current->right != NULL) {
                enqueue(current->right);
            }
        }
    }

    return bottomLeftValue;
}