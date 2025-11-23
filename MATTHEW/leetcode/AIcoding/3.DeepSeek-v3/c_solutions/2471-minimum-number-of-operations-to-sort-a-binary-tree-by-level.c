/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    int val;
    int idx;
} Node;

int compare(const void* a, const void* b) {
    return ((Node*)a)->val - ((Node*)b)->val;
}

int minSwaps(int* arr, int n) {
    Node* nodes = (Node*)malloc(n * sizeof(Node));
    for (int i = 0; i < n; i++) {
        nodes[i].val = arr[i];
        nodes[i].idx = i;
    }

    qsort(nodes, n, sizeof(Node), compare);

    int* visited = (int*)calloc(n, sizeof(int));
    int swaps = 0;

    for (int i = 0; i < n; i++) {
        if (visited[i] || nodes[i].idx == i) continue;

        int cycle_size = 0;
        int j = i;
        while (!visited[j]) {
            visited[j] = 1;
            j = nodes[j].idx;
            cycle_size++;
        }

        if (cycle_size > 1) {
            swaps += (cycle_size - 1);
        }
    }

    free(nodes);
    free(visited);
    return swaps;
}

int minimumOperations(struct TreeNode* root) {
    if (!root) return 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(100000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    int operations = 0;

    while (front < rear) {
        int level_size = rear - front;
        int* level_vals = (int*)malloc(level_size * sizeof(int));

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* node = queue[front++];
            level_vals[i] = node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        operations += minSwaps(level_vals, level_size);
        free(level_vals);
    }

    free(queue);
    return operations;
}