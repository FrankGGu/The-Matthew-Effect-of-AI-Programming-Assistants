class Solution {
public:
    bool isSubStructure(TreeNode* A, TreeNode* B) {
        if (A == nullptr || B == nullptr) return false;
        return isMatch(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B);
    }

    bool isMatch(TreeNode* A, TreeNode* B) {
        if (B == nullptr) return true;
        if (A == nullptr) return false;
        if (A->val != B->val) return false;
        return isMatch(A->left, B->left) && isMatch(A->right, B->right);
    }
};