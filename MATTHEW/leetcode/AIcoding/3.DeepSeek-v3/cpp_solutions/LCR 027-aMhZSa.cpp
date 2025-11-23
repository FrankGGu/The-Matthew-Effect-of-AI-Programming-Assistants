class Solution {
public:
    bool isPalindrome(ListNode* head) {
        if (!head || !head->next) return true;

        ListNode* slow = head;
        ListNode* fast = head;
        ListNode* prev = nullptr;

        while (fast && fast->next) {
            fast = fast->next->next;
            ListNode* nextTemp = slow->next;
            slow->next = prev;
            prev = slow;
            slow = nextTemp;
        }

        if (fast) slow = slow->next;

        while (prev && slow) {
            if (prev->val != slow->val) return false;
            prev = prev->next;
            slow = slow->next;
        }

        return true;
    }
};