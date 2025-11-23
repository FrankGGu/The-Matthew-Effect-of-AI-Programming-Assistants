class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        if (!head || !head->next) return head;
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* prev = dummy;
        ListNode* curr = head;
        while (curr && curr->next) {
            ListNode* first = curr;
            ListNode* second = curr->next;
            prev->next = second;
            first->next = second->next;
            second->next = first;
            prev = first;
            curr = first->next;
        }
        return dummy->next;
    }
};