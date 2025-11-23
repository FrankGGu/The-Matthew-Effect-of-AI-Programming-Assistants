/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* findLeaf(struct TreeNode* root, int target) {
    if (!root) return NULL;
    if (!root->left && !root->right && root->val == target) return root;
    struct TreeNode* left = findLeaf(root->left, target);
    if (left) return left;
    return findLeaf(root->right, target);
}

struct TreeNode* canMerge(struct TreeNode** trees, int treesSize) {
    if (treesSize == 1) return trees[0];

    int map[50001] = {0};
    int rootCount[50001] = {0};

    for (int i = 0; i < treesSize; i++) {
        rootCount[trees[i]->val]++;
        if (trees[i]->left) {
            map[trees[i]->left->val]++;
        }
        if (trees[i]->right) {
            map[trees[i]->right->val]++;
        }
    }

    struct TreeNode* root = NULL;
    for (int i = 0; i < treesSize; i++) {
        if (map[trees[i]->val] == 0) {
            if (root) return NULL;
            root = trees[i];
        }
    }
    if (!root) return NULL;

    int used[50001] = {0};
    used[root->val] = 1;

    struct TreeNode* queue[50001];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        struct TreeNode* node = queue[front++];

        if (node->left && !node->left->left && !node->left->right) {
            for (int i = 0; i < treesSize; i++) {
                if (trees[i]->val == node->left->val && !used[trees[i]->val]) {
                    node->left = trees[i];
                    used[trees[i]->val] = 1;
                    break;
                }
            }
        }

        if (node->right && !node->right->left && !node->right->right) {
            for (int i = 0; i < treesSize; i++) {
                if (trees[i]->val == node->right->val && !used[trees[i]->val]) {
                    node->right = trees[i];
                    used[trees[i]->val] = 1;
                    break;
                }
            }
        }

        if (node->left) queue[rear++] = node->left;
        if (node->right) queue[rear++] = node->right;
    }

    for (int i = 0; i < treesSize; i++) {
        if (!used[trees[i]->val]) return NULL;
    }

    int count = 0;
    struct TreeNode* stack[50001];
    int top = -1;
    struct TreeNode* curr = root;
    int prev = -1;

    while (curr || top != -1) {
        while (curr) {
            stack[++top] = curr;
            curr = curr->left;
        }
        curr = stack[top--];
        if (prev != -1 && curr->val <= prev) return NULL;
        prev = curr->val;
        curr = curr->right;
    }

    return root;
}