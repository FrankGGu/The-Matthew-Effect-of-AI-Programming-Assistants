#include <vector>
#include <string>

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
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> paths;
        if (!root) return paths;

        function<void(TreeNode*, string)> dfs = [&](TreeNode* node, string path) {
            if (!node->left && !node->right) {
                paths.push_back(path + to_string(node->val));
                return;
            }

            path += to_string(node->val) + "->";

            if (node->left) {
                dfs(node->left, path);
            }
            if (node->right) {
                dfs(node->right, path);
            }
        };

        dfs(root, "");
        return paths;
    }
};