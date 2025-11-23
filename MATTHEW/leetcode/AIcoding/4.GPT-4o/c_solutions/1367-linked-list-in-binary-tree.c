bool isSubPath(struct ListNode* head, struct TreeNode* root) {
    if (!root) return false;
    if (checkPath(head, root)) return true;
    return isSubPath(head, root->left) || isSubPath(head, root->right);
}

bool checkPath(struct ListNode* head, struct TreeNode* node) {
    if (!head) return true;
    if (!node) return false;
    if (head->val != node->val) return false;
    return checkPath(head->next, node->left) || checkPath(head->next, node->right);
}