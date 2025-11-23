#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int findSize(TreeNode* node, int& target) {
        if (!node) return 0;
        int left = findSize(node->left, target);
        int right = findSize(node->right, target);
        int total = left + right + 1;
        if (total == target) {
            target = 0;
        }
        return total;
    }

    bool btreeGameWinningMove(TreeNode* root, int n, int x) {
        int sizeLeft = findSize(root->left, x);
        int sizeRight = findSize(root->right, x);
        int sizeRoot = sizeLeft + sizeRight + 1;
        return max(sizeLeft, max(sizeRight, sizeRoot - sizeLeft - sizeRight - 1)) > n / 2;
    }
};