class Solution {
public:
    ListNode* doubleIt(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        ListNode* curr = dummy;
        ListNode* prev = nullptr;
        int carry = 0;

        while (head) {
            int value = head->val * 2 + carry;
            carry = value / 10;
            curr->next = new ListNode(value % 10);
            curr = curr->next;
            head = head->next;
        }

        if (carry) {
            curr->next = new ListNode(carry);
        }

        return reverseList(dummy->next);
    }

private:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr) {
            ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
};