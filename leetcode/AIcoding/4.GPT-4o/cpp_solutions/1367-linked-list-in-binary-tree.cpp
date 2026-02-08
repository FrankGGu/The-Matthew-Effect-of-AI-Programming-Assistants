class Solution {
public:
    bool isSubPath(ListNode* head, TreeNode* root) {
        if (!root) return false;
        return dfs(head, root) || isSubPath(head, root->left) || isSubPath(head, root->right);
    }

    bool dfs(ListNode* head, TreeNode* node) {
        if (!head) return true;
        if (!node) return false;
        if (node->val != head->val) return false;
        return dfs(head->next, node->left) || dfs(head->next, node->right);
    }
};