class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if (!head || !head->next || k == 0) {
            return head;
        }

        // 1. Find the length of the list and the original tail
        ListNode* current = head;
        int length = 1;
        while (current->next) {
            current = current->next;
            length++;
        }
        ListNode* original_tail = current; 

        // 2. Calculate effective k
        k = k % length;
        if (k == 0) {
            return head; 
        }

        // 3. Find the new tail (the node before the new head)
        // The new tail will be at (length - k - 1)th index from the start (0-indexed)
        int steps_to_new_tail = length - k - 1;
        ListNode* new_tail = head;
        for (int i = 0; i < steps_to_new_tail; ++i) {
            new_tail = new_tail->next;
        }

        // 4. The new head is the node after the new tail
        ListNode* new_head = new_tail->next;

        // 5. Make the list circular by connecting original tail to original head
        original_tail->next = head;

        // 6. Break the circle by setting new_tail->next to nullptr
        new_tail->next = nullptr;

        // 7. Return the new head
        return new_head;
    }
};