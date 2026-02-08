#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int diameter(TreeNode* root) {
        int maxDiameter = 0;
        depth(root, maxDiameter);
        return maxDiameter;
    }

    int depth(TreeNode* node, int& maxDiameter) {
        if (!node) return 0;
        int leftDepth = depth(node->left, maxDiameter);
        int rightDepth = depth(node->right, maxDiameter);
        maxDiameter = max(maxDiameter, leftDepth + rightDepth);
        return max(leftDepth, rightDepth) + 1;
    }

    int findMinimumDiameter(TreeNode* root1, TreeNode* root2, int m) {
        int d1 = diameter(root1);
        int d2 = diameter(root2);
        vector<int> diameters = {d1, d2};
        sort(diameters.begin(), diameters.end());
        return max(0, diameters[0] + diameters[1] - 2 * m);
    }
};