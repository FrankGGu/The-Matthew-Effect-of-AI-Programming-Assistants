class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        if (!head || !head->next) return head;

        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* prev = dummy;
        ListNode* curr = head;

        while (curr && curr->next) {
            ListNode* nextNode = curr->next;
            curr->next = nextNode->next;
            nextNode->next = curr;
            prev->next = nextNode;

            prev = curr;
            curr = curr->next;
        }

        ListNode* newHead = dummy->next;
        delete dummy;
        return newHead;
    }
};