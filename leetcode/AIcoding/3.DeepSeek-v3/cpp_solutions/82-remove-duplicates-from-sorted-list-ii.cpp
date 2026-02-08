class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        ListNode dummy(0);
        dummy.next = head;
        ListNode* prev = &dummy;

        while (head != nullptr) {
            if (head->next != nullptr && head->val == head->next->val) {
                int val = head->val;
                while (head != nullptr && head->val == val) {
                    ListNode* temp = head;
                    head = head->next;
                    delete temp;
                }
                prev->next = head;
            } else {
                prev = head;
                head = head->next;
            }
        }

        return dummy.next;
    }
};