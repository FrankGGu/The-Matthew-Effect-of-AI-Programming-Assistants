#include <string>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    string smallestFromLeaf(TreeNode* root) {
        string ans = "~";
        dfs(root, "", ans);
        return ans;
    }

private:
    void dfs(TreeNode* node, string current, string& ans) {
        if (!node) return;

        current = char(node->val + 'a') + current;

        if (!node->left && !node->right) {
            ans = min(ans, current);
            return;
        }

        dfs(node->left, current, ans);
        dfs(node->right, current, ans);
    }
};