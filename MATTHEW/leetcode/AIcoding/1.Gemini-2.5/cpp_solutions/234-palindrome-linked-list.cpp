class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr != nullptr) {
            ListNode* nextTemp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = nextTemp;
        }
        return prev;
    }

    bool isPalindrome(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return true;
        }

        ListNode* slow = head;
        ListNode* fast = head;

        while (fast->next != nullptr && fast->next->next != nullptr) {
            slow = slow->next;
            fast = fast->next->next;
        }

        ListNode* second_half_start = slow->next;
        slow->next = nullptr; 

        ListNode* reversed_second_half_head = reverseList(second_half_start);

        ListNode* p1 = head;
        ListNode* p2 = reversed_second_half_head;
        bool is_palindrome = true;
        while (p1 != nullptr && p2 != nullptr) {
            if (p1->val != p2->val) {
                is_palindrome = false;
                break;
            }
            p1 = p1->next;
            p2 = p2->next;
        }

        return is_palindrome;
    }
};