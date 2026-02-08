class Solution {
public:
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> paths;
        if (!root) return paths;
        string path;
        dfs(root, path, paths);
        return paths;
    }

    void dfs(TreeNode* node, string& path, vector<string>& paths) {
        path += to_string(node->val);
        if (!node->left && !node->right) {
            paths.push_back(path);
        } else {
            path += "->";
            if (node->left) dfs(node->left, path, paths);
            if (node->right) dfs(node->right, path, paths);
        }
        path.erase(path.end() - to_string(node->val).length() - (node->left || node->right ? 2 : 0), path.end());
    }
};