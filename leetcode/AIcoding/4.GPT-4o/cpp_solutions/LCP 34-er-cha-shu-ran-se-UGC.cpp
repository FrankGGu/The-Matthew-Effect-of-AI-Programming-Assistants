class Solution {
public:
    bool isBipartite(TreeNode* root) {
        if (!root) return true;
        unordered_map<TreeNode*, int> color;
        queue<TreeNode*> q;
        q.push(root);
        color[root] = 0;

        while (!q.empty()) {
            TreeNode* node = q.front(); q.pop();
            for (TreeNode* neighbor : {node->left, node->right}) {
                if (neighbor) {
                    if (color.count(neighbor) == 0) {
                        color[neighbor] = 1 - color[node];
                        q.push(neighbor);
                    } else if (color[neighbor] == color[node]) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
};