class Solution {
public:
    void reorderList(ListNode* head) {
        if (!head || !head->next) return;

        ListNode* slow = head;
        ListNode* fast = head;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
        }

        ListNode* secondHalf = slow->next;
        slow->next = nullptr;

        ListNode* prev = nullptr;
        ListNode* curr = secondHalf;
        while (curr) {
            ListNode* nextNode = curr->next;
            curr->next = prev;
            prev = curr;
            curr = nextNode;
        }

        secondHalf = prev;

        ListNode* firstHalf = head;
        while (secondHalf) {
            ListNode* firstNext = firstHalf->next;
            ListNode* secondNext = secondHalf->next;

            firstHalf->next = secondHalf;
            secondHalf->next = firstNext;

            firstHalf = firstNext;
            secondHalf = secondNext;
        }
    }
};