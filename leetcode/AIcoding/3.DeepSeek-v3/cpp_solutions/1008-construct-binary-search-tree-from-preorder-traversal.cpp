class Solution {
public:
    TreeNode* bstFromPreorder(vector<int>& preorder) {
        int index = 0;
        return helper(preorder, index, INT_MIN, INT_MAX);
    }

    TreeNode* helper(vector<int>& preorder, int& index, int lower, int upper) {
        if (index >= preorder.size() || preorder[index] < lower || preorder[index] > upper) {
            return nullptr;
        }
        int val = preorder[index++];
        TreeNode* root = new TreeNode(val);
        root->left = helper(preorder, index, lower, val);
        root->right = helper(preorder, index, val, upper);
        return root;
    }
};