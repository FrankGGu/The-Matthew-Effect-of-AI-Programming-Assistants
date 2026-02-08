class Solution {
public:
    bool isSameTree(TreeNode* p, TreeNode* q) {
        if (!p && !q) {
            return true;
        }
        if (!p || !q || p->val != q->val) {
            return false;
        }
        return isSameTree(p->left, q->left) && isSameTree(p->right, q->right);
    }

    bool isSubtree(TreeNode* s, TreeNode* t) {
        if (!t) {
            return false;
        }
        if (!s) {
            return false;
        }

        if (isSameTree(s, t)) {
            return true;
        }

        return isSubtree(s->left, t) || isSubtree(s->right, t);
    }
};