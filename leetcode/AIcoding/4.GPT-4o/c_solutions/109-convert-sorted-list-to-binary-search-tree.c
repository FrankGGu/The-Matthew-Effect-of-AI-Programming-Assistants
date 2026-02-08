struct TreeNode* sortedListToBST(struct ListNode* head) {
    if (!head) return NULL;

    struct ListNode *slow = head, *fast = head, *prev = NULL;
    while (fast && fast->next) {
        prev = slow;
        slow = slow->next;
        fast = fast->next->next;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = slow->val;
    root->left = sortedListToBST(prev ? head : NULL);
    root->right = sortedListToBST(slow->next);

    return root;
}