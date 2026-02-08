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
    string getDirections(TreeNode* root, int startValue, int destValue) {
        TreeNode* lca = findLCA(root, startValue, destValue);
        string startPath = "";
        string destPath = "";
        findPath(lca, startValue, startPath, 'U');
        findPath(lca, destValue, destPath, ' ');
        return startPath + destPath;
    }

private:
    TreeNode* findLCA(TreeNode* root, int startValue, int destValue) {
        if (!root) return nullptr;
        if (root->val == startValue || root->val == destValue) return root;
        TreeNode* left = findLCA(root->left, startValue, destValue);
        TreeNode* right = findLCA(root->right, startValue, destValue);
        if (left && right) return root;
        return left ? left : right;
    }

    bool findPath(TreeNode* root, int target, string& path, char direction) {
        if (!root) return false;
        if (root->val == target) return true;
        if (direction == 'U') path += 'U';
        if (direction == 'L') path += 'L';
        if (direction == 'R') path += 'R';

        if (findPath(root->left, target, path, 'L')) return true;
        if (direction != 'U') path.pop_back();

        if (findPath(root->right, target, path, 'R')) return true;
        if (direction != 'U') path.pop_back();

        if (direction != 'U') path.pop_back();

        return false;
    }
};