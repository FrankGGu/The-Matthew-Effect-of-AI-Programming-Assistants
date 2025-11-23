class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if (!head || !head->next || k == 0) return head;

        ListNode* curr = head;
        int length = 1;

        while (curr->next) {
            curr = curr->next;
            length++;
        }

        curr->next = head; // Make it a circular list
        k = k % length; // In case k is greater than length

        int stepsToNewHead = length - k;
        curr = head;

        for (int i = 0; i < stepsToNewHead - 1; i++) {
            curr = curr->next;
        }

        ListNode* newHead = curr->next;
        curr->next = nullptr; // Break the circle

        return newHead;
    }
};