class Solution {
public:
    ListNode* insertionSortList(ListNode* head) {
        if (!head) return nullptr;

        ListNode* sorted = new ListNode(0); // Dummy head for sorted list
        ListNode* current = head;

        while (current) {
            ListNode* prev = sorted; // Start from the dummy head
            ListNode* next = current->next; // Store next node

            while (prev->next && prev->next->val < current->val) {
                prev = prev->next; // Find the right position to insert
            }

            current->next = prev->next; // Insert current node
            prev->next = current;
            current = next; // Move to the next node
        }

        return sorted->next; // Return the sorted list
    }
};