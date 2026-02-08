#include <vector>
#include <unordered_map>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int countPalindromicPaths(TreeNode* root) {
        unordered_map<int, int> freq;
        return dfs(root, freq, 0);
    }

private:
    int dfs(TreeNode* node, unordered_map<int, int>& freq, int count) {
        if (!node) return 0;
        count ^= (1 << node->val);
        if (!node->left && !node->right) {
            return (count & (count - 1)) == 0 ? 1 : 0;
        }
        int res = dfs(node->left, freq, count) + dfs(node->right, freq, count);
        return res;
    }
};