class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        ListNode before(0), after(0);
        ListNode* before_ptr = &before;
        ListNode* after_ptr = &after;

        while (head) {
            if (head->val < x) {
                before_ptr->next = head;
                before_ptr = before_ptr->next;
            } else {
                after_ptr->next = head;
                after_ptr = after_ptr->next;
            }
            head = head->next;
        }

        after_ptr->next = nullptr;
        before_ptr->next = after.next;

        return before.next;
    }
};