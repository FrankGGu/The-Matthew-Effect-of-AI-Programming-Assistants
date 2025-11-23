class Solution {
public:
    ListNode* insertionSortList(ListNode* head) {
        if (!head || !head->next) {
            return head;
        }

        ListNode* dummy = new ListNode(0);
        ListNode* current = head;

        while (current) {
            ListNode* prev = dummy;
            while (prev->next && prev->next->val < current->val) {
                prev = prev->next;
            }

            ListNode* next_node = current->next;
            current->next = prev->next;
            prev->next = current;
            current = next_node;
        }

        ListNode* sorted_head = dummy->next;
        delete dummy;
        return sorted_head;
    }
};