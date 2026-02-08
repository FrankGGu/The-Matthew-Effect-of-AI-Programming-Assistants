void deleteNode(struct ListNode* node) {
    struct ListNode* temp = node->next;
    node->val = temp->val;
    node->next = temp->next;
    free(temp);
}