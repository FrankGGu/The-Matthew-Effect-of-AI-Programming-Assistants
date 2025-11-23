class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        ListNode less_head(0);
        ListNode greater_head(0);
        ListNode *less_tail = &less_head;
        ListNode *greater_tail = &greater_head;

        while (head) {
            if (head->val < x) {
                less_tail->next = head;
                less_tail = head;
            } else {
                greater_tail->next = head;
                greater_tail = head;
            }
            head = head->next;
        }

        greater_tail->next = nullptr;
        less_tail->next = greater_head.next;

        return less_head.next;
    }
};