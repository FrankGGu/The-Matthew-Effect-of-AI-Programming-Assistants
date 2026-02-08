#include <vector>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<int> sizes;

    int dfs(TreeNode* node) {
        if (!node) return 0;
        int leftSize = dfs(node->left);
        int rightSize = dfs(node->right);
        int totalSize = leftSize + rightSize + 1;
        sizes.push_back(totalSize);
        return totalSize;
    }

    int kthLargest(TreeNode* root, int k) {
        dfs(root);
        sort(sizes.begin(), sizes.end(), greater<int>());
        return sizes[k - 1];
    }
};