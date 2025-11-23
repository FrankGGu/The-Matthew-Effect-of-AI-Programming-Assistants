/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */
typedef struct {
    struct TreeNode* nodes[1000];
    int size;
} Path;

void findPath(struct TreeNode* root, struct TreeNode* target, Path* path, int* found) {
    if (root == NULL || *found) return;

    path->nodes[path->size++] = root;

    if (root == target) {
        *found = 1;
        return;
    }

    findPath(root->left, target, path, found);
    if (*found) return;

    findPath(root->right, target, path, found);
    if (*found) return;

    path->size--;
}

struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    Path path1, path2;
    int found1 = 0, found2 = 0;

    path1.size = 0;
    path2.size = 0;

    findPath(root, p, &path1, &found1);
    findPath(root, q, &path2, &found2);

    int i = 0;
    while (i < path1.size && i < path2.size && path1.nodes[i] == path2.nodes[i]) {
        i++;
    }

    return path1.nodes[i - 1];
}

int minCameraCover(struct TreeNode* root) {
    if (root == NULL) return 0;

    struct TreeNode* cameras[1000];
    int camCount = 0;

    struct TreeNode* queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    struct TreeNode* parent[1001] = {0};
    int visited[1001] = {0};

    while (front < rear) {
        struct TreeNode* node = queue[front++];
        if (node->left) {
            parent[node->left->val] = node;
            queue[rear++] = node->left;
        }
        if (node->right) {
            parent[node->right->val] = node;
            queue[rear++] = node->right;
        }
    }

    for (int i = rear - 1; i >= 0; i--) {
        struct TreeNode* node = queue[i];
        if (!visited[node->val] && 
            (node->left && !visited[node->left->val] || node->right && !visited[node->right->val] || 
             parent[node->val] && !visited[parent[node->val]->val])) {
            cameras[camCount++] = node;
            visited[node->val] = 1;
            if (node->left) visited[node->left->val] = 1;
            if (node->right) visited[node->right->val] = 1;
            if (parent[node->val]) visited[parent[node->val]->val] = 1;
        }
    }

    return camCount;
}

int navigation(struct TreeNode* root) {
    if (root == NULL) return 0;
    if (root->left == NULL && root->right == NULL) return 1;

    int leftCams = minCameraCover(root->left);
    int rightCams = minCameraCover(root->right);

    if (root->left && root->right) {
        return leftCams + rightCams;
    } else if (root->left) {
        return leftCams + 1;
    } else {
        return rightCams + 1;
    }
}