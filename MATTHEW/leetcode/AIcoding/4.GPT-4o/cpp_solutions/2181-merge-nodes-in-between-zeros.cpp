class Solution {
public:
    ListNode* mergeNodes(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        ListNode* current = dummy;
        int sum = 0;

        ListNode* node = head->next; // Start from the first node after the first zero
        while (node) {
            if (node->val == 0) {
                if (sum > 0) {
                    current->next = new ListNode(sum);
                    current = current->next;
                    sum = 0;
                }
            } else {
                sum += node->val;
            }
            node = node->next;
        }

        return dummy->next;
    }
};