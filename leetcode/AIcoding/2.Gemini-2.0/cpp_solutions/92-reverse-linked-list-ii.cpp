class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int left, int right) {
        if (!head || left == right) return head;

        ListNode dummy(0);
        dummy.next = head;
        ListNode* pre = &dummy;

        for (int i = 1; i < left; ++i) {
            pre = pre->next;
        }

        ListNode* cur = pre->next;
        for (int i = 0; i < right - left; ++i) {
            ListNode* nextNode = cur->next;
            cur->next = nextNode->next;
            nextNode->next = pre->next;
            pre->next = nextNode;
        }

        return dummy.next;
    }
};