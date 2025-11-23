class Solution {
public:
    TreeNode* bstFromPreorder(vector<int>& preorder) {
        return construct(preorder, 0, preorder.size() - 1);
    }

    TreeNode* construct(vector<int>& preorder, int start, int end) {
        if (start > end) return nullptr;
        TreeNode* root = new TreeNode(preorder[start]);
        int rightStart = start + 1;
        while (rightStart <= end && preorder[rightStart] < root->val) {
            rightStart++;
        }
        root->left = construct(preorder, start + 1, rightStart - 1);
        root->right = construct(preorder, rightStart, end);
        return root;
    }
};