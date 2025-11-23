class Solution {
public:
    ListNode* mergeInBetween(ListNode* list1, int a, int b, ListNode* list2) {
        ListNode* pre_a = list1;
        for (int i = 0; i < a - 1; ++i) {
            pre_a = pre_a->next;
        }

        ListNode* b_node = list1;
        for (int i = 0; i < b; ++i) {
            b_node = b_node->next;
        }

        ListNode* post_b = b_node->next;

        pre_a->next = list2;

        ListNode* list2_tail = list2;
        while (list2_tail->next != nullptr) {
            list2_tail = list2_tail->next;
        }

        list2_tail->next = post_b;

        return list1;
    }
};