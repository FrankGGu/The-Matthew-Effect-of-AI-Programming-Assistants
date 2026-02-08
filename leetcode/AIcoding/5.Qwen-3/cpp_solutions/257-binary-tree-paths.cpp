#include <iostream>
#include <vector>
#include <string>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> result;
        string path;
        dfs(root, path, result);
        return result;
    }

private:
    void dfs(TreeNode* node, string path, vector<string>& result) {
        if (!node) return;
        path += to_string(node->val);
        if (!node->left && !node->right) {
            result.push_back(path);
            return;
        }
        path += "->";
        dfs(node->left, path, result);
        dfs(node->right, path, result);
    }
};