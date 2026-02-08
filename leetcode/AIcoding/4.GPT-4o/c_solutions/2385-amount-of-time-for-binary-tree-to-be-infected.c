int amountOfTime(struct TreeNode* root, int start) {
    int ans = 0;
    int found = 0;
    int parent[10001] = {0};

    void dfs(struct TreeNode* node, int p) {
        if (!node) return;
        parent[node->val] = p;
        dfs(node->left, node->val);
        dfs(node->right, node->val);
    }

    void bfs(int start) {
        int time = 0;
        int queue[10001], front = 0, back = 0;
        int visited[10001] = {0};

        queue[back++] = start;
        visited[start] = 1;

        while (front < back) {
            int size = back - front;
            for (int i = 0; i < size; i++) {
                int node = queue[front++];
                if (node == -1) continue;
                if (parent[node] && !visited[parent[node]]) {
                    visited[parent[node]] = 1;
                    queue[back++] = parent[node];
                }
                if (node->left && !visited[node->left->val]) {
                    visited[node->left->val] = 1;
                    queue[back++] = node->left->val;
                }
                if (node->right && !visited[node->right->val]) {
                    visited[node->right->val] = 1;
                    queue[back++] = node->right->val;
                }
            }
            time++;
        }
        ans = time - 1;
    }

    dfs(root, -1);
    for (int i = 0; i < 10001; i++) {
        if (parent[i] == start) {
            found = 1;
            break;
        }
    }
    bfs(start);
    return ans;
}