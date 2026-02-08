class Solution {
public:
    ListNode* reverseEvenLengthGroups(ListNode* head) {
        ListNode dummy(0, head);
        ListNode* prev = &dummy;
        ListNode* curr = head;
        int group_len = 1;

        while (curr != nullptr) {
            ListNode* group_start = curr;
            ListNode* group_end = curr;
            int current_group_count = 1;

            while (group_end->next != nullptr && current_group_count < group_len) {
                group_end = group_end->next;
                current_group_count++;
            }

            if (current_group_count % 2 == 0) {
                ListNode* next_node_after_group = group_end->next;
                ListNode* first_node_of_group = group_start;
                ListNode* last_node_of_group = group_end;

                ListNode* current_rev = group_start;
                ListNode* prev_rev = next_node_after_group;
                ListNode* temp_next_rev;

                while (current_rev != next_node_after_group) {
                    temp_next_rev = current_rev->next;
                    current_rev->next = prev_rev;
                    prev_rev = current_rev;
                    current_rev = temp_next_rev;
                }

                prev->next = last_node_of_group;
                prev = first_node_of_group;
                curr = next_node_after_group;
            } else {
                prev = group_end;
                curr = group_end->next;
            }
            group_len++;
        }

        return dummy.next;
    }
};