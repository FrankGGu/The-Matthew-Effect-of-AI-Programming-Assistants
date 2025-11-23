class Solution {
public:
    ListNode* doubleIt(ListNode* head) {
        ListNode* reversed = reverseList(head);
        ListNode* current = reversed;
        ListNode* prev = nullptr;
        int carry = 0;

        while (current != nullptr) {
            int sum = current->val * 2 + carry;
            current->val = sum % 10;
            carry = sum / 10;
            prev = current;
            current = current->next;
        }

        if (carry > 0) {
            prev->next = new ListNode(carry);
        }

        return reverseList(reversed);
    }

private:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* current = head;

        while (current != nullptr) {
            ListNode* nextNode = current->next;
            current->next = prev;
            prev = current;
            current = nextNode;
        }

        return prev;
    }
};