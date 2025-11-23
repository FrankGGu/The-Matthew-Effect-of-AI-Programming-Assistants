class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* pre = dummy;
        ListNode* cur = head;

        while (cur) {
            ListNode* tail = pre;
            for (int i = 0; i < k; ++i) {
                tail = tail->next;
                if (!tail) {
                    return dummy->next;
                }
            }

            ListNode* nextGroupHead = tail->next;

            ListNode* prev = pre->next;
            ListNode* curr = prev->next;
            for (int i = 1; i < k; ++i) {
                ListNode* next = curr->next;
                curr->next = prev;
                prev = curr;
                curr = next;
            }

            pre->next->next = nextGroupHead;
            pre->next = prev;

            pre = cur;
            cur = nextGroupHead;
        }

        return dummy->next;
    }
};