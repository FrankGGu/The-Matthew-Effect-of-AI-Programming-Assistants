class Solution {
public:
    ListNode* insertionSortList(ListNode* head) {
        if (!head || !head->next) return head;

        ListNode* dummy = new ListNode(0);
        ListNode* curr = head;

        while (curr) {
            ListNode* prev = dummy;
            ListNode* nextNode = curr->next;

            while (prev->next && prev->next->val < curr->val) {
                prev = prev->next;
            }

            curr->next = prev->next;
            prev->next = curr;
            curr = nextNode;
        }

        return dummy->next;
    }
};