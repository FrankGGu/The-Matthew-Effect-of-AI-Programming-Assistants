class Solution {
public:
    ListNode* removeElements(ListNode* head, int val) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* current = dummy;

        while (current->next != nullptr) {
            if (current->next->val == val) {
                ListNode* nodeToDelete = current->next;
                current->next = current->next->next;
                delete nodeToDelete; // Free memory for the removed node
            } else {
                current = current->next;
            }
        }

        ListNode* newHead = dummy->next;
        delete dummy; // Free dummy node
        return newHead;
    }
};