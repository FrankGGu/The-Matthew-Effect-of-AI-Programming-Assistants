struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode** levelOrder(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 100;
    struct ListNode** result = malloc(capacity * sizeof(struct ListNode*));
    for (int i = 0; i < capacity; i++) {
        result[i] = NULL;
    }

    int front = 0, rear = 0;
    struct TreeNode** queue = malloc(capacity * sizeof(struct TreeNode*));
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        struct ListNode* head = NULL;
        struct ListNode* tail = NULL;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            struct ListNode* newNode = malloc(sizeof(struct ListNode));
            newNode->val = node->val;
            newNode->next = NULL;

            if (!head) {
                head = tail = newNode;
            } else {
                tail->next = newNode;
                tail = newNode;
            }

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        result[*returnSize] = head;
        (*returnSize)++;
    }

    free(queue);
    return result;
}