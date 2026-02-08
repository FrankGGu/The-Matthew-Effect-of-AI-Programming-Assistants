class Solution {
public:
    ListNode* removeNodes(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }

        ListNode* modified_next = removeNodes(head->next);

        if (head->val < modified_next->val) {
            return modified_next;
        } else {
            head->next = modified_next;
            return head;
        }
    }
};