class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if (!head || !head->next || k == 0) return head;

        ListNode* tail = head;
        int length = 1;
        while (tail->next) {
            tail = tail->next;
            length++;
        }

        k = k % length;
        if (k == 0) return head;

        tail->next = head;
        ListNode* new_tail = head;
        for (int i = 0; i < length - k - 1; ++i) {
            new_tail = new_tail->next;
        }

        head = new_tail->next;
        new_tail->next = nullptr;

        return head;
    }
};