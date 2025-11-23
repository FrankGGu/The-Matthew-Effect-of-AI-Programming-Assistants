#define MAX_NODES 3000

typedef struct {
    struct TreeNode* node;
    unsigned long long index;
} QueueNode;

int widthOfBinaryTree(struct TreeNode* root) {
    if (!root) return 0;

    QueueNode queue[MAX_NODES];
    int front = 0, rear = 0;
    unsigned long long max_width = 0;

    queue[rear].node = root;
    queue[rear].index = 1;
    rear++;

    while (front < rear) {
        int level_size = rear - front;
        unsigned long long left_index = queue[front].index;
        unsigned long long right_index = queue[rear - 1].index;

        if (right_index - left_index + 1 > max_width) {
            max_width = right_index - left_index + 1;
        }

        for (int i = 0; i < level_size; i++) {
            QueueNode current = queue[front++];

            if (current.node->left) {
                queue[rear].node = current.node->left;
                queue[rear].index = current.index * 2;
                rear++;
            }

            if (current.node->right) {
                queue[rear].node = current.node->right;
                queue[rear].index = current.index * 2 + 1;
                rear++;
            }
        }
    }

    return (int)max_width;
}