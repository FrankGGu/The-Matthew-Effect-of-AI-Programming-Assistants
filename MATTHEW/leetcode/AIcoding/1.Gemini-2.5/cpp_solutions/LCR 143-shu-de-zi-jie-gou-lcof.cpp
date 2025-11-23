class Solution {
public:
    bool check(TreeNode* A, TreeNode* B) {
        if (B == nullptr) {
            return true;
        }
        if (A == nullptr || A->val != B->val) {
            return false;
        }
        return check(A->left, B->left) && check(A->right, B->right);
    }

    bool isSubStructure(TreeNode* A, TreeNode* B) {
        if (A == nullptr || B == nullptr) {
            return false;
        }
        return check(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B);
    }
};