class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        ListNode* lessHead = new ListNode(0);
        ListNode* greaterHead = new ListNode(0);

        ListNode* lessPtr = lessHead;
        ListNode* greaterPtr = greaterHead;

        ListNode* current = head;

        while (current != nullptr) {
            if (current->val < x) {
                lessPtr->next = current;
                lessPtr = lessPtr->next;
            } else {
                greaterPtr->next = current;
                greaterPtr = greaterPtr->next;
            }
            current = current->next;
        }

        greaterPtr->next = nullptr;
        lessPtr->next = greaterHead->next;

        ListNode* result = lessHead->next;
        delete lessHead;
        delete greaterHead;

        return result;
    }
};