int* nodesBetweenCriticalPoints(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    int depth = 0, minDist = INT_MAX, maxDist = -1, prevPos = -1, firstPos = -1;
    void dfs(struct TreeNode* node, int pos) {
        if (!node) return;

        depth++;
        if (!node->left && !node->right) { // Leaf node
            if (firstPos >= 0 && prevPos >= 0) {
                int dist = pos - prevPos;
                if (dist < minDist) minDist = dist;
                if (dist > maxDist) maxDist = dist;
            }
            if (firstPos == -1) firstPos = pos;
            prevPos = pos;
        }

        dfs(node->left, pos * 2);
        dfs(node->right, pos * 2 + 1);
        depth--;
    }

    dfs(root, 0);

    if (minDist == INT_MAX) {
        result[0] = -1;
        result[1] = -1;
    } else {
        result[0] = minDist;
        result[1] = maxDist;
    }

    return result;
}