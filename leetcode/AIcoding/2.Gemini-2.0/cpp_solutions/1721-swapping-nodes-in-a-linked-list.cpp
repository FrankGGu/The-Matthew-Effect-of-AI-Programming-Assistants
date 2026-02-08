class Solution {
public:
    ListNode* swapNodes(ListNode* head, int k) {
        ListNode* first = nullptr;
        ListNode* second = nullptr;
        ListNode* temp = head;

        int count = 0;
        while (temp != nullptr) {
            count++;
            if (count == k) {
                first = temp;
            }
            temp = temp->next;
        }

        temp = head;
        for (int i = 0; i < count - k; i++) {
            temp = temp->next;
        }
        second = temp;

        int val = first->val;
        first->val = second->val;
        second->val = val;

        return head;
    }
};