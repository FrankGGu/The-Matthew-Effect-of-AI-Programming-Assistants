#include <vector>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode* sortedArrayToBST(std::vector<int>& nums) {
        return convertToBST(nums, 0, nums.size() - 1);
    }

    TreeNode* convertToBST(std::vector<int>& nums, int left, int right) {
        if (left > right) return nullptr;
        int mid = left + (right - left) / 2;
        TreeNode* node = new TreeNode(nums[mid]);
        node->left = convertToBST(nums, left, mid - 1);
        node->right = convertToBST(nums, mid + 1, right);
        return node;
    }
};