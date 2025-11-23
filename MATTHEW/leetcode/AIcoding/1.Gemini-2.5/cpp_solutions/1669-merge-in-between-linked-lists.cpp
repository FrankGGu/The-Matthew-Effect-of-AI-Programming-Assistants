class Solution {
public:
    ListNode* mergeInBetween(ListNode* list1, ListNode* list2, int a, int b) {
        ListNode* dummy = new ListNode(0);
        dummy->next = list1;

        ListNode* prev_a = dummy;
        for (int i = 0; i < a; ++i) {
            prev_a = prev_a->next;
        }

        ListNode* node_b = list1;
        for (int i = 0; i < b; ++i) {
            node_b = node_b->next;
        }

        ListNode* tail_list2 = list2;
        while (tail_list2->next != nullptr) {
            tail_list2 = tail_list2->next;
        }

        prev_a->next = list2;
        tail_list2->next = node_b->next;

        ListNode* result = dummy->next;
        return result;
    }
};