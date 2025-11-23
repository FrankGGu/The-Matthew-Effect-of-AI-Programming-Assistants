class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* prev = dummy;

        while (prev->next != nullptr && prev->next->next != nullptr) {
            ListNode* node1 = prev->next;
            ListNode* node2 = prev->next->next;

            // Perform the swap
            node1->next = node2->next;
            node2->next = node1;
            prev->next = node2;

            // Move to the next pair
            prev = node1;
        }

        ListNode* newHead = dummy->next;
        delete dummy; // Clean up dummy node
        return newHead;
    }
};