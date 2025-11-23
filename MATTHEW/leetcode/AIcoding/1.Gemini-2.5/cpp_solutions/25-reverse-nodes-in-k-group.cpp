class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        if (!head || k == 1) {
            return head;
        }

        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* group_prev = dummy;

        while (true) {
            ListNode* group_start = group_prev->next;
            ListNode* group_end = group_prev;

            for (int i = 0; i < k; ++i) {
                group_end = group_end->next;
                if (!group_end) {
                    return dummy->next;
                }
            }

            ListNode* next_group_start = group_end->next;

            ListNode* prev_in_group = next_group_start;
            ListNode* curr = group_start;
            for (int i = 0; i < k; ++i) {
                ListNode* next_node = curr->next;
                curr->next = prev_in_group;
                prev_in_group = curr;
                curr = next_node;
            }

            group_prev->next = prev_in_group;
            group_prev = group_start;
        }
    }
};