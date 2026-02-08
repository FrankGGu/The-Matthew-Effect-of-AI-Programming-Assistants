class Solution {
public:
    ListNode* insertionSortList(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = nullptr;
        ListNode* curr = head;

        while (curr != nullptr) {
            ListNode* nextNode = curr->next;
            ListNode* prev = dummy;
            ListNode* search = dummy->next;

            while (search != nullptr && search->val < curr->val) {
                prev = search;
                search = search->next;
            }

            curr->next = search;
            prev->next = curr;
            curr = nextNode;
        }

        return dummy->next;
    }
};