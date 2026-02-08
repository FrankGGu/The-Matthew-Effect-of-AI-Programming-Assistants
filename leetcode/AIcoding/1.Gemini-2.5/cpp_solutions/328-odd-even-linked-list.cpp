class Solution {
public:
    ListNode* oddEvenList(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }

        ListNode* odd_head = head;
        ListNode* even_head = head->next;

        ListNode* odd_ptr = odd_head;
        ListNode* even_ptr = even_head;

        while (even_ptr != nullptr && even_ptr->next != nullptr) {
            odd_ptr->next = even_ptr->next;
            odd_ptr = odd_ptr->next;
            even_ptr->next = odd_ptr->next;
            even_ptr = even_ptr->next;
        }

        odd_ptr->next = even_head;

        return head;
    }
};