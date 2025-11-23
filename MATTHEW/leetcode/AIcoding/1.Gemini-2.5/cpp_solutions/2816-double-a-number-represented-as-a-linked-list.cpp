class Solution {
public:
    int doubleAndCarry(ListNode* node) {
        if (node == nullptr) {
            return 0;
        }

        int carry_from_next = doubleAndCarry(node->next);

        int doubled_val = node->val * 2 + carry_from_next;

        node->val = doubled_val % 10;

        return doubled_val / 10;
    }

    ListNode* doubleIt(ListNode* head) {
        int final_carry = doubleAndCarry(head);

        if (final_carry > 0) {
            ListNode* new_head = new ListNode(final_carry);
            new_head->next = head;
            return new_head;
        } else {
            return head;
        }
    }
};