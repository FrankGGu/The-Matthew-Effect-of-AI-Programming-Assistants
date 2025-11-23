class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr) {
            ListNode* nextTemp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = nextTemp;
        }
        return prev;
    }

    bool isPalindrome(ListNode* head) {
        if (!head || !head->next) {
            return true;
        }

        ListNode* slow = head;
        ListNode* fast = head;
        while (fast->next && fast->next->next) {
            slow = slow->next;
            fast = fast->next->next;
        }

        ListNode* secondHalfHead = reverseList(slow->next);

        ListNode* p1 = head;
        ListNode* p2 = secondHalfHead;
        bool isPal = true;

        while (p2) {
            if (p1->val != p2->val) {
                isPal = false;
                break;
            }
            p1 = p1->next;
            p2 = p2->next;
        }

        slow->next = reverseList(secondHalfHead); 

        return isPal;
    }
};